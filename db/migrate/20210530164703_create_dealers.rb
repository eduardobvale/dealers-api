class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :name
      t.string :phone
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :country
      t.decimal :latitude, :precision => 6, :scale => 10
      t.decimal :longitude, :precision => 6, :scale => 10

      t.timestamps
    end
  end
end
