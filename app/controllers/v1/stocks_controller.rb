module V1
  class StocksController < ApplicationController
    def create
      result = Stocks::Create.call(stock_params)

      if result.success?
        render json: StockSerializer.render(result.stock)
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    private

    def stock_params
      params.require(:stock).permit(:name, :bearer_name)
    end
  end
end
