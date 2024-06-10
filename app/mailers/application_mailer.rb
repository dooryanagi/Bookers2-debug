class ApplicationMailer < ActionMailer::Base
  # サンプルアドレスでも最初はOK
  default from: "グループオーナー　<owner@example.com>"
  layout 'mailer'
end


