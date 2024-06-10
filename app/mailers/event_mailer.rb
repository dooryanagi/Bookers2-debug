class EventMailer < ApplicationMailer

  # イベントの開催情報をメールでお知らせしたい
  def send_email_holding_event(user,event)
    # イベントカラムのgroupという意味？
    @group = event[:group]
    @title = event[:title]
    @contents = event[:contents]

    # 作成したインスタンス変数にmailメソッドを適用
    @mail = EventMailer.new()
    mail(
      from:     ENV['SECRET_email'],
      to:       user.email,
      # ここにイベント名を入れることは可能？
      subject:  'New Event Notice!!'
    )
  end

  # イベントの開催情報をグループメンバー全員にメールでお知らせしたい
  def self.send_email_holding_events_to_group(group, event)
    group_users = group.group_users
    group_users.each do |group_user|
      user = group_user.user
      EventMailer.send_email_holding_event(user,event).deliver_now
    end
  end

end