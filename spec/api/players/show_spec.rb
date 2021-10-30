# frozen_string_literal: true

require 'api_helper'

# rubocop:disable RSpec/EmptyExampleGroup
resource 'Players' do
  explanation 'Get Player profile'

  header 'Accept', 'application/json'

  get '/api/players/:id' do
    parameter :id, 'ID of Player', type: :integer, required: true

    context 'with 200 status' do
      let(:player) { create(:player) }
      let(:scores) { create_list(:score, 3, player: player) }
      let(:id) { player.id }

      before do
        player.scores
      end

      example_request 'Getting a single player' do
        json = JSON.parse(response_body)

        expect(status).to eq(200)
        expect(json['player']).to be_present
      end
    end

    context 'with 400 status' do
      example_request 'Getting a single playe - errors' do
        json = JSON.parse(response_body)

        expect(status).to eq(400)
        expect(json['errors']).to include({
                                            'code' => 400_003, 'field' => 'id', 'message' => 'is not a number'
                                          })
      end
    end
  end
end
# rubocop:enable RSpec/EmptyExampleGroup
