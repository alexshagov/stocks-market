# frozen_string_literal: true

RSpec::Matchers.define :match_json_schema do |schema|
  match do |response|
    schema_path = "#{Dir.pwd}/spec/support/json_schemas/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body)
  end
end
