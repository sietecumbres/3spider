module Helpers
  
  def current_user
    @current_user ||= User.find_by_email(session[:email])
    @current_user.password = session[:password] if @current_user
    @current_user
  end
  
  def login!(user)
    @current_user = user
    session[:email] = user.email
    session[:password] = user.password
  end
  
  def logged_in?
    @current_user ? true : false
  end
  
  def login_required
    redirect '/login' and return unless current_user
  end
  
  def send_email(user, subject, body)
    body = haml(body)
    to = user.contacts.collect{|contact| contact.email}
    
      Pony.mail(:to => to,
        :from       => user.email,
        :subject    => subject,
        :body       => body,
        :via        => :smtp,
        :headers    => { 'Content-Type' => 'text/html' },
        :via_options  => {
          :address        => 'smtp.sendgrid.net',
          :port           => '25',
          :user_name      => 'juange88@gmail.com',
          :password       => 'jespinosa',
          :authentication => :plain
        })
  end

end