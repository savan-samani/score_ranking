# frozen_string_literal: true

# forzen_string_literal: true

# This module encapsulates some of the basic query features such as:
#   includes: records' associated models
#   select:   records' returned fields
#   limit:    limit the maximum number of records returned by the query
#   offset:   number of rows skipped before returning the records
#
# To use this module in your class add:
#
#   include Searchable
#
# For the module to know what model your class wants to search,
# specify the model class and the serializer they are referring:
#
#   search_from model: MyModel, serializer: MyModelSerializer
#
# This will enable the block method `perform_search` to build
# the respective queries regarding includes, select, limit, offset
# around the block.
module Searchable
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    attr_accessor :includes, # String
                  :select, # String
                  :offset, # Int
                  :limit # Int

    attr_reader :query # Score::ActiveRecord_Relation

    validates :limit, numericality: { greater_than: 0 }, allow_blank: true
    validates :offset, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  end

  class_methods do
    attr_reader :base_model

    def search_from(model:, serializer:)
      @base_model ||= model
      validates :select, csv_inclusion: { in: serializer._attributes }
      validates :includes, csv_inclusion: { in: serializer._reflections.keys }
    end
  end

  def perform_search
    @query = build_base_query

    @query = yield @query

    paginate(@query)
  end

  def total_count
    @query.size
  end

  def include_in_serializer
    return [] if includes.blank?

    includes.split(',')
  end

  private

  # Base
  def build_base_query
    base = self.class.base_model

    base = base.includes(includes.split(',')) if includes.present?
    base = base.select(select.split(',')) if select.present?

    base
  end

  # Pagination
  def paginate(result)
    return result if limit.blank?

    if offset.present?
      result.limit(limit).offset(offset)
    else
      result.limit(limit)
    end
  end
end
