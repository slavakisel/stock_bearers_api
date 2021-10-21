class Stock < ApplicationRecord
  belongs_to :bearer

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
