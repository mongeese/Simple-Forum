class UserMailer < ActionMailer::Base
  
  def password_reset(user, new_password, sent_at = Time.now)
    subject    'Password Reminder'
    recipients user.email
    from       ''
    sent_on    sent_at
    
    body['user'] = user
    body['user']['new_password'] = new_password
  end

end
