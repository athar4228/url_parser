require 'nokogiri'
require 'open-uri'

class UrlParser

  attr_accessor :url, :h1s, :h2s, :h3s, :anchors, :success, :response

  def initialize(url)
    @url = url
    @h1s = []
    @h2s = []
    @h3s = []
    @anchors = []
    @success = true
    @response = {}

    parse_url
  end

  def parse_url
    begin
      doc = Nokogiri::HTML(open(url))
      parse_content(doc)
    rescue => e
      @success = false
      @response = {error: e}
    end
    self
  end

  def failed?
    @success == false
  end

  def create_response
    url_response = UrlResponse.new( url: @url)
    url_response.content = {h1:  @h1s, h2: @h2s, h3: @h3s, anchor: @anchors}
    url_response.save
    url_response
  end

  private

  def parse_content(doc)
    parse_h1s(doc)
    parse_h2s(doc)
    parse_h3s(doc)
    parse_anchors(doc)
  end

  def parse_h1s(doc)
    @h1s = doc.xpath('//h1').collect { |h1| h1.text }
  end

  def parse_h2s(doc)
    @h2s = doc.xpath('//h2').collect { |h2| h2.text }
  end

  def parse_h3s(doc)
    @h3s = doc.xpath('//h3').collect { |h3| h3.text }
  end

  def parse_anchors(doc)
    @anchors = doc.xpath('//a').collect { |h3| h3['href'] }
  end
end
