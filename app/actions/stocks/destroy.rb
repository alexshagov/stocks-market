module Stocks
  class Destroy
    attr_reader :stock

    def initialize(stock)
      @stock = stock
    end

    def self.call(stock)
      new(stock).call
    end

    def call
      stock.destroy
    end
  end
end
