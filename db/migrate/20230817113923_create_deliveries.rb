class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string     :postcode,      null: false
      t.integer    :prefecture_id, null: false
      t.string     :city,          null: false
      t.string     :address,     null: false
      t.string     :building,      null: false
      t.string     :phonenumber,   null: false
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
