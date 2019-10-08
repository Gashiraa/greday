class ChangeCommentToTextWares < ActiveRecord::Migration[5.2]
  def change
    change_column :wares, :comment, :text
  end
end
