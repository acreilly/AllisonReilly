class CreateWeddingGuests < ActiveRecord::Migration
  def change
    create_table :wedding_guests do |t|
      t.string :firstname
      t.string :lastname
      t.boolean :ceremony
      t.boolean :reception
      t.references :wedding_party, index: true
    end
  end
end