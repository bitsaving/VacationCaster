class CreateListingsSearches < ActiveRecord::Migration
  def change
    create_table :listings_searches do |t|
      t.references :listing
      t.references :search
    end
    add_index :listings_searches, [:listing_id, :search_id]
    add_index :listings_searches, :search_id
  end
end
