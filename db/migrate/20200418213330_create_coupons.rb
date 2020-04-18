class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.integer :percent_off
      t.integer :quantity_required
    end
  end
end
