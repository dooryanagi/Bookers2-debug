class EventsController < ApplicationController
  def new
    # からのイベントを作成する前に、親となるグループを探してくる必要がある
    # form_withのためにnewでも定義
    @event = Event.new
    @group = Group.find(params[:group_id])
  end

  def create
    # もととなるgroup情報（group_id)を取得
    @group = Group.find(params[:group_id])
    @event = Event.new(event_params)
    @event.save
    # URLから必要情報をそれぞれ取得
    @title = params[:title]
    @contents = params[:contents]

    # イベントの詳細情報を格納するハッシュを作成
    event = {
      :group => @group,
      :title => @title,
      :contents => @contents
    }

    EventMailer.send_email_holding_events_to_group(@group, event)
    render :sent
  end

  # 送信完了画面
  def sent
    @event = Event.find(params[:group_id])
    # ここにビュー用の変数定義は不要？？なぜ？
    # なんでredirect_toがいるんだろう？
    redirect_to group_path(params[group_id])
  end


  private

  def event_params
    params.require(:event).permit(:title, :contents)
  end

end
