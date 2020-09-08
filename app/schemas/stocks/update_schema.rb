module Stocks
  class UpdateSchema
    class << self
      def build(params)
        Dry::Schema.JSON do
          required(:name).filled(:string)
        end.call(params)
      end
    end
  end
end
