class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|

      # カラムを直接指定
      t.integer :user_id
      t.integer :book_id
      t.text :comment

      t.timestamps
    end
  end
end
