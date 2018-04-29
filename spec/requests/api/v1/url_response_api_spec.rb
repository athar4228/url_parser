require 'rails_helper'

describe 'Url Response API' do

  describe 'GET /api/v1/url-responses' do
    context 'Url Responses exists' do
      let!(:url_response) { create(:url_response) }

      before(:each) do
        get '/api/v1/url-responses/'
      end

      it 'responds with 200 Status' do
        expect(response.status).to eql(200)
      end

      it 'responds with Url Responses' do
        expect(json['data'].length).to eq(1)
        expect(json['data'].first['type']).to eql('url-responses')
        expect(json['data'].first['attributes']).to include(
                    'url' => url_response.url,
                    'h1' => url_response.h1,
                    'h2' => url_response.h2,
                    'h3' => url_response.h3,
                    'anchor' => url_response.anchor,
                )
      end
    end
  end

  describe 'POST /api/v1/url-responses' do
    context 'Url is invalid' do
      let!(:data) {
        {
          'url': 'http://huelmcclure.info/weston' #Cannot use Faker as it generates correct urls at time
        }
      }

      before(:each) do
        post '/api/v1/url-responses/',
        params: data.as_json
      end

      it 'responds with 422 Status' do
        expect(response.status).to eql(422)
      end

      it 'responds with errors' do
        expect(json['error']).not_to be(nil)
      end
    end

    context 'Url is valid' do
      let!(:data) {
        { 'url': 'http://youtube.com' }
      }

      before(:each) do
        post '/api/v1/url-responses/',
        params: data.as_json
      end

      it 'responds with 201 Status' do
        expect(response.status).to eql(201)
      end
    end
  end
end
