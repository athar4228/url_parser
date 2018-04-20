require 'rails_helper'

RSpec.describe UrlResponse, type: :model do

  context '#create' do
    it { should validate_presence_of(:url) }
  end
end
