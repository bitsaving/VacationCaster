class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :options
      t.string :name
      t.string :slug
      t.date :start_date
      t.date :end_date
      t.integer :user_id

      t.timestamps
    end
  end
end
