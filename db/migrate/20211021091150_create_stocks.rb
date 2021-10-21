class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.references :bearer, null: false, foreign_key: true

      t.timestamps
    end

    execute "CREATE UNIQUE INDEX index_stocks_on_lowercase_name ON stocks USING btree (lower(name));"
  end
end
