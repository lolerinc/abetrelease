# Be sure to restart your server when you modify this file.

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.gmail.com',
    :domain         => 'mail.google.com',
    :port           => 587,
    :user_name      => 'abetcoordinatortamucc@gmail.com',
    :password       => 'abetc00rdinator',
    :authentication => :plain
}
