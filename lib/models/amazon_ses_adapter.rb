class AmazonSESAdapter
  
  class << self
    
    def credentials
      config = YAML.load_file('ses.yml')
      AWS::SES::Base.new(
        :access_key_id => config['access_key_id'],
        :secret_access_key => config['secret_access_key']
      )
    end
    
    def send_email(user, subject, body)
      body = haml(body, :layout => false)
      to = user.contacts.collect{|contact| contact.email}
      
        Pony.mail(:to  => to,
          :from        => user.email,
          :subject     => subject,
          :body        => body,
          :via            => :smtp,
          :via_options => {
            :address     => 'smtp.sendgrid.net',
            :port           => '25',
            :user_name    => 'juange88@gmail.com',
            :password       => 'jespinosa',
            :authentication    => :plain
          })
    end
    
    def verify_address(email)
      credentials.addresses.verify(email)
    end
    
    def get_verified_addresses
      credentials.addresses.list.result
    end
    
  end
  
end