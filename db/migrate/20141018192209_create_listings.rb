class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.decimal :price, :precision => 8, :scale => 2
      t.float :lat
      t.float :lng
      t.text :calendar_data
      t.integer :lid

      t.timestamps
    end
  end
end
