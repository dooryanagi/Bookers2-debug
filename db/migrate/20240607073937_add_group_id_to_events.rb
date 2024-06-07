class AddGroupIdToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :group_id, :integer
  end
end
