class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :titre
      t.string :image
      t.timestamps
    end
  end
end
