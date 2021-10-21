module Stocks
  class Create
    include Interactor

    delegate :name, :bearer_name, to: :context

    def call
      unless save_records
        collect_errors
        context.fail!
      end
    end

    private

    def save_records
      ActiveRecord::Base.transaction do
        bearer.save!
        stock.save!
      end
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => _e
      false
    end

    def stock
      context.stock ||= Stock.new(name: name, bearer: bearer)
    end

    def bearer
      context.bearer ||= Bearers::FindOrInitialize.new(bearer_name).run
    end

    def collect_errors
      context.errors = {
        stock: stock.errors,
        bearer: bearer.errors
      }
    end
  end
end
