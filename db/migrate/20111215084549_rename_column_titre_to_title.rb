class RenameColumnTitreToTitle < ActiveRecord::Migration
  def change
    rename_column :products, :titre, :title
  end
end
