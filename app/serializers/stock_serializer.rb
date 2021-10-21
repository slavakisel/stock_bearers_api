class StockSerializer < ApplicationSerializer
  fields :name

  association :bearer, blueprint: BearerSerializer
end
