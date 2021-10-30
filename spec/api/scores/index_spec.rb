# frozen_string_literal: true

require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
resource 'Scores' do
  explanation 'Create, read & delete scores'

  header 'Accept', 'application/json'

  get '/api/scores' do
    parameter :name, 'Name of players. CSV (i.e: "name1,name2")', type: :string
    parameter :after_score_date, 'Date after score_at (i.e: "2021-05-10")', type: :string
    parameter :before_score_date, 'Date before score_at (i.e: "2021-05-19")', type: :string
    parameter :limit, 'Limits the current query.', type: :integer, required: true
    parameter :offset, 'Starting offset of the current query', type: :integer, required: true

    context 'with 200 status' do
      let(:score) { create(:score) }
      let(:name) { score.player.name }
      let(:after_score_date) { (score.score_at - 1.day).strftime('%Y-%m-%d') }
      let(:before_score_date) { (score.score_at + 1.day).strftime('%Y-%m-%d') }
      let(:limit) { 10 }
      let(:offset) { 0 }

      example_request 'Getting a list of scores' do
        json = JSON.parse(response_body)

        expect(status).to eq(200)
        expect(json['scores']).to be_present
        expect(json['meta']['total_count']).to be_present
      end
    end

    context 'with 400 status' do
      example_request 'Getting a list of scores - errors' do
        json = JSON.parse(response_body)

        expect(status).to eq(400)
        expect(json['errors']).to include({
                                            'code' => 400_000, 'message' => 'Contains incorrect parameter type.'
                                          })
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
