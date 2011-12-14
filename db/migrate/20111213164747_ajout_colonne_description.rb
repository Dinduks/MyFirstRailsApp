class AjoutColonneDescription < ActiveRecord::Migration
  def up
    change_table :articles do |t|
      t.text     :description
    end
  end
end
