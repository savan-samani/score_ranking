# frozen_string_literal: true

require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
resource 'Scores' do
  explanation 'Create, read & delete scores'

  header 'Accept', 'application/json'

  get '/api/scores/:id' do
    let(:score) { create(:score) }

    context 'with 200 status' do
      let(:id) { score.id }

      example_request 'Get a single score' do
        json = JSON.parse(response_body)

        expect(status).to eq(200)
        expect(json['score']).to be_present
        expect(json['score']['player']).to be_present
      end
    end

    context 'with 400 status' do
      let(:id) { 0 }

      example_request 'Get a single score - errors' do
        json = JSON.parse(response_body)

        expect(status).to eq(404)
        expect(json['errors']).to include({
                                            'code' => 404_002, 'message' => 'The target item does not exist.'
                                          })
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
