class CreateBearers < ActiveRecord::Migration[6.1]
  def change
    create_table :bearers do |t|
      t.string :name, null: false

      t.timestamps
    end

    execute "CREATE UNIQUE INDEX index_bearers_on_lowercase_name ON bearers USING btree (lower(name));"
  end
end
