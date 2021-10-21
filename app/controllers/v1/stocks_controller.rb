module V1
  class StocksController < ApplicationController
    def index
      stocks = stocks_scope.page(params[:page]).per(50)

      respond_with(stocks, serializer_opts: { root: :stocks, meta: pagination_meta(stocks) })
    end

    def create
      result = Stocks::Create.call(stock_params)

      if result.success?
        respond_with(result.stock, status: :created)
      else
        respond_with_error(result.errors)
      end
    end

    def update
      stock = stocks_scope.find(params[:id])
      result = Stocks::Update.call(stock: stock, **stock_params)

      if result.success?
        respond_with(result.stock)
      else
        respond_with_error(result.errors)
      end
    end

    def destroy
      stock = stocks_scope.find(params[:id])
      stock.discard

      render json: {}, status: :ok
    end

    private

    def stocks_scope
      Stock.kept
    end

    def stock_params
      params.require(:stock).permit(:name, :bearer_name)
    end

    def respond_with(stock_payload, options = {})
      serializer_opts = options.fetch(:serializer_opts, {})
      render_opts = options.except(:serializer_opts)

      render json: StockSerializer.render(stock_payload, **serializer_opts), **render_opts
    end

    def respond_with_error(error_payload)
      render json: { errors: error_payload }, status: :unprocessable_entity
    end
  end
end
