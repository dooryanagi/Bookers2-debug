class RelationshipsController < ApplicationController

  def create
    # urlからuseridを取得
    user = User.find(params[:user_id])
    # followeridをuseridから取得、空のインスタンスも作成
    follow = current_user.active_relationships.new(follower_id: user.id)
    # followingidを自分のuseridから取得
    # follow.following_id = current_user.id
    follow.save
    redirect_back fallback_location: users_path
  end

  def destroy
    user = User.find(params[:user_id])
    follow = current_user.active_relationships.find_by(follower_id: user.id)
    # followがnillというエラーが出るので、修正
    # follow.following_id = current_user.id
    follow.destroy
    redirect_back fallback_location: users_path
  end

end
