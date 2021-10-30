# frozen_string_literal: true

require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
resource 'Scores' do
  explanation 'Create, read & delete scores'

  header 'Accept', 'application/json'
  header 'Content-type', 'application/json'

  post '/api/scores' do
    with_options scope: :score do
      parameter :name, 'Name of player', type: :string, required: true
      parameter :score_point, 'Score of player', type: :integer, required: true
      parameter :score_at, 'Score time of player', type: :string, required: true
    end

    context 'with 200 status' do
      let(:name) { 'player_name' }
      let(:score_point) { 10 }
      let(:score_at) { '2021-05-19T12:00:00+09:00' }

      context 'with player' do
        example_request 'Creating a score' do
          json = JSON.parse(response_body)

          expect(status).to eq(200)
          expect(json['score']).to be_present
          expect(json['score']['player']).to be_present
        end
      end
    end

    context 'with 400 status' do
      let(:name) { nil }
      let(:score_point) { 'score' }
      let(:score_at) { '2021-05-19 12:00:00 JST' }

      example_request 'Creating a score - errors' do
        json = JSON.parse(response_body)

        expect(status).to eq(400)
        expect(json['errors']).to include({
                                            'code' => 400_003, 'message' => 'is not a number', 'field' => 'score_point'
                                          })
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
