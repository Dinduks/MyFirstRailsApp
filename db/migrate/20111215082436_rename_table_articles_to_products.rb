class RenameTableArticlesToProducts < ActiveRecord::Migration
  def change
    rename_table :articles, :products
  end
end
