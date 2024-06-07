class ApplicationMailer < ActionMailer::Base
  # サンプルアドレスでも最初は
  default from: 'from@example.com'
  layout 'mailer'
end
