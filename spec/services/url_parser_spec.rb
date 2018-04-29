require 'rails_helper'

RSpec.describe UrlParser, type: :service_api do

  describe 'Url Parsing' do
    context 'Url is invalid' do
      let!(:url) { 'http://huelmcclure.info/weston' }

      it 'returns error if url is invalid' do
        url_parser = UrlParser.new(url)
        expect(url_parser.response[:error]).not_to be(nil)
        expect(url_parser.failed?).to be(true)
      end
    end

    context 'Url is valid' do
      let!(:url) { 'http://youtube.com' }

      it 'returns site content' do
        VCR.use_cassette('valid_url_parsed') do
          url_parser = UrlParser.new(url)
          expect(url_parser.failed?).to be(false)
          expect(url_parser.h1s.length).to be(0)
          expect(url_parser.h2s.length).to be(9)
          expect(url_parser.h3s.length).to be(90)
          expect(url_parser.anchors.length).to be(307)
        end
      end

      it 'returns new url_response istance' do
        VCR.use_cassette('valid_url_parsed') do
          url_parser = UrlParser.new(url)
          url_response = url_parser.create_response
          expect(url_response.valid?).to be(true)
          expect(url_response.id).not_to be(nil)
        end
      end
    end
  end
end
