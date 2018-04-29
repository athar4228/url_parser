class UrlResponse < ApplicationRecord

  attr_accessor :h1, :h2, :h3, :anchor
  validates :url, presence: true

  def h1
    content['h1']
  end

  def h2
    content['h2']
  end

  def h3
    content['h3']
  end

  def anchor
    content['anchor']
  end
end
