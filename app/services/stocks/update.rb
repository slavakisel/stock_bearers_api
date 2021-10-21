module Stocks
  class Update
    include Interactor

    delegate :stock, :name, :bearer_name, to: :context

    def call
      unless stock.update(stock_params)
        collect_errors
        context.fail!
      end
    end

    private

    def stock_params
      { name: name }.merge(bearer_params)
    end

    def bearer_params
      if bearer_changed?
        { bearer: bearer }
      else
        {}
      end
    end

    def bearer_changed?
      bearer.id != stock.bearer.id
    end

    def bearer
      context.bearer ||=
        if bearer_name.present?
          Bearers::FindOrInitialize.new(bearer_name).run
        else
          stock.bearer
        end
    end

    def collect_errors
      context.errors = {
        stock: stock.errors,
        bearer: bearer.errors
      }
    end
  end
end
