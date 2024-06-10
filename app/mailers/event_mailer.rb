class EventMailer < ApplicationMailer
  
  # イベントの開催情報をメールでお知らせしたい
  def send_email_holding_event(member,event)
    # イベントカラムのgroupという意味？
    @group = events[:group_id]
    @title = events[:title]
    @contents = events[:contents]
    
    @mail = EventMaler.new()
    # 作成したインスタンス変数にmailメソッドを適用
    @mail.mail(
      from:     ENV['SECRET_email'],
      to:       member.email,
      # ここにイベント名を入れることは可能？
      subject:  'New Event Notice!!'
      )
  end
  
end