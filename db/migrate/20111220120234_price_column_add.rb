class PriceColumnAdd < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.float     :price
    end
  end
end
