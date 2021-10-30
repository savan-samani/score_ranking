# frozen_string_literal: true

require 'rspec/core/rake_task'

desc 'Generate API request documentation from API specs'
RSpec::Core::RakeTask.new('docs:generate_api') do |t|
  t.pattern = 'spec/api/**/*_spec.rb'
  t.rspec_opts = ['--format RspecApiDocumentation::ApiFormatter']
end
