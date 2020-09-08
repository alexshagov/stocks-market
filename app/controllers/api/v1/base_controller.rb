module Api
  module V1
    class BaseController < ApplicationController
      private

      def perform_create!(schema:, action:, representer:)
        schema_validation = schema.build(permitted_params)
        if schema_validation.success?
          render json: representer.prepare(action.call(params)).to_json, status: 201
        else
          render json: schema_validation.errors.to_h.inspect, status: 422
        end
      end

      def perform_update!(schema:, action:, entity:, representer:)
        schema_validation = schema.build(permitted_params)
        if schema_validation.success?
          render json: representer.prepare(action.call(params, entity)).to_json, status: 200
        else
          render json: schema_validation.errors.to_h.inspect, status: 422
        end
      end

      def perform_destroy!(action:, entity:)
        action.call(entity)
        render json: nil, status: 204
      end

      def permitted_params
        params.permit!.to_h
      end
    end
  end
end
