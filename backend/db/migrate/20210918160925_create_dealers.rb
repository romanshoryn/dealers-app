class CreateDealers < ActiveRecord::Migration[6.1]
  def change
    create_table :dealers, { id: false } do |t|
      t.uuid :id, primary_key: true
      t.string :name
      t.string :phone
      t.string :street
      t.string :city
      t.string :zipcode
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
