class AddDiscardedAtToStocks < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :discarded_at, :datetime
    add_index :stocks, :discarded_at
  end
end
