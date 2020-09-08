require 'roar/json/json_api'

class StocksRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :stocks

  attributes do
    property :name
    property :reference
    property :bearer, decorator: BearerRepresenter
  end
end
