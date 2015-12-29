class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title
      t.string :filename
      t.string :location
      t.date :date_created
      t.string :technologies
      t.string :category
      t.string :link
      t.text :description
    end
  end
end