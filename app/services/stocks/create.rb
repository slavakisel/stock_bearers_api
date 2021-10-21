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

    def collect_errors
      context.errors = {
        stock: stock.errors,
        bearer: bearer.errors
      }
    end

    def stock
      context.stock ||= Stock.new(name: name, bearer: bearer)
    end

    def bearer
      context.bearer ||= (find_bearer || Bearer.new(name: bearer_name))
    end

    def find_bearer
      Bearer.where("lower(name) = ?", bearer_name&.downcase).first
    end
  end
end
