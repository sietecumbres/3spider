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
      verified_addresses = get_verified_addresses
      emails_list = user.contacts_list.collect{|contact| contact if verified_addresses.include?(contact)}.flatten
      credentials.send_email  :to => emails_list,
                              :source => user.email,
                              :subject => subject,
                              :text_body => body
    end
    
    def verify_address(email)
      credentials.addresses.verify(email)
    end
    
    def get_verified_addresses
      credentials.addresses.list.result
    end
    
  end
  
end