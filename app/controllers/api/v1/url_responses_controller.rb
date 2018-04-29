module Api::V1
  class UrlResponsesController < ApiController

    before_action :fetch_site_content, only: [:create]

    def index
      @url_responses = UrlResponse.page(params[:page])
      render json: json_resources(UrlResponseResource, @url_responses), status: :ok
    end

    def create
      @url_response = @url_parser.create_response
      if @url_response
        render json: json_resource(UrlResponseResource, @url_response), status: :created
      else
        render json: json_resource(UrlResponseResource, @url_response.errors), status: :unprocessable_entity
      end
    end

    private

    def fetch_site_content
      @url_parser = UrlParser.new(params[:url])
      if @url_parser.failed?
        render json: @url_parser.response, status: :unprocessable_entity
      end
    end
  end
end
