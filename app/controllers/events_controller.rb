class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    # もととなるgroup情報（group_id)を取得
    @group = Group.find(params[:group_id])
    @event = Event.new(event_params)
    # groupと関連付ける
    @event.group_id = @group.id
    # メールを送るためにuserを定義
    @user = User.group_users
    @event.save
    # ここにメール送信機能を追加
    EventMailer.send_when_reply(@user, @event).deliver
    # 送信完了画面も併せて作成したい
    redirect_to groups_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :contents)
  end

end
