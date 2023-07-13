email = "anhquyet@gmail.com"
if AdminUser.find_by(email: email).blank?
  admin_user = AdminUser.new
  admin_user.email = 'anhquyet@gmail.com'
  admin_user.password = '123123'
  admin_user.password_confirmation = '123123'
  admin_user.save!
end
