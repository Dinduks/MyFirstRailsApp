class AjoutColonneAdmin < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.boolean  :admin, :default => false
    end
  end
end
