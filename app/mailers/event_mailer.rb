class EventMailer < ApplicationMailer
  
  # イベントの開催情報をGroupUserにメールでお知らせしたい
  def send_when_reply(user,event)
    # 定義内容がいまいちわからない
    @users = User.group_users
    @ = Event.contents
    mail to: @users.email, subject: '【<%= @enent.title %>を開催します！】'
  end
  
end
