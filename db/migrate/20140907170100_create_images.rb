class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.string :location
      t.string :category
      t.string :link
      t.text :description
    end
  end
end