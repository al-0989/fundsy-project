ActionMailer::Base.smtp_settings = {
  address:              "smtp.gmail.com",
  port:                 "587",
  enable_starttls_auto: true,
  authentication:       :plain,
  user_name:            Rails.application.secrets.email_user_name,
  password:             Rails.application.secrets.email_password
}
