require 'roar/json/json_api'

class BearerRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :bearers

  attributes do
    property :name
    property :reference
  end
end
