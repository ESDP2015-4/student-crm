class UserMailer < ApplicationMailer
  default from: 'esdpattractor@gmail.com'

  def invitation_to_period_event(user, period)
    @user = user
    @period = period
    @url  = 'http://esdp-15-4.ltestl.com/'
    mail(to: @user.email, subject: 'У вас сегодня занятие!')
  end
end
