class RemoveCategoryFromProviders < ActiveRecord::Migration
  def change
    remove_column :providers, :category_id, :integer
  end
end
