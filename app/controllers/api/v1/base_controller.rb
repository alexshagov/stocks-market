module Api
  module V1
    class BaseController < ApplicationController
      private

      def create!(schema:, action:, representer:)
        schema_validation = schema.build(permitted_params)
        if schema_validation.success?
          render json: representer.prepare(action.call(params)).to_json
        else
          render json: schema_validation.errors.to_h.inspect
        end
      end

      def permitted_params
        params.permit!.to_h
      end
    end
  end
end
