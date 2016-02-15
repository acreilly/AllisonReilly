class CreateWeddingParties < ActiveRecord::Migration
  def change
    create_table :wedding_parties do |t|
      t.string :email
    end
  end
end