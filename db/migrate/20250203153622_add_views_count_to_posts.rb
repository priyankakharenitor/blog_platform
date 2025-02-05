class AddViewsCountToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :views_count, :integer, default: 0
  end
end
