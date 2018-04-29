class Api::V1::ApiController < ApplicationController

 def json_resource(klass, record, context = nil)
    JSONAPI::ResourceSerializer.new(klass).serialize_to_hash(klass.new(record, context))
  end

  def json_resources(klass, records, context = nil)
    resources = records.map { |record| klass.new(record, context) }
    JSONAPI::ResourceSerializer.new(klass).serialize_to_hash(resources)
  end
end
