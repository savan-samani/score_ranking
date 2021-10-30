# frozen_string_literal: true

require 'api_helper'

resource 'Scores' do
  explanation 'Create, read & delete scores'

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let!(:score) { create(:score) }

  delete '/api/scores/:id' do
    let(:id) { score.id }

    context 'with 200 status' do
      example 'Deleting an score' do
        expect do
          do_request
        end.to change(Score, :count).by(-1)

        expect(status).to eq(200)
      end
    end
  end
end
