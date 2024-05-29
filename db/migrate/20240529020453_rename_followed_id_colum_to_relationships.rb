class RenameFollowedIdColumToRelationships < ActiveRecord::Migration[6.1]
  def change
    # テーブル名、変更前のカラム名、変更後のカラム名
    rename_column :relationships, :followed_id, :following_id
  end
end
