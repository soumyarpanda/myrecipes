class ChangeRecipes < ActiveRecord::Migration
  def change
    change_column :recipes, :summary, :text
    change_column :recipes, :description, :text
  end
end
