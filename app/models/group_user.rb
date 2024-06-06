class GroupUser < ApplicationRecord
  
  belongs_to :user
  belongs_to :group
  
  #一人で何度も同じグループに所属することは出来ない
  validates :user_id, uniqueness: {scope: :group_id}
  
end
