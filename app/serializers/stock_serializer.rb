class StockSerializer < ApplicationSerializer
  field :name

  association :bearer, blueprint: BearerSerializer
end
