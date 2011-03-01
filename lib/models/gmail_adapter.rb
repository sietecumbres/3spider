class GmailAdapter
  
  attr_accessor :user, :mailbox
  
  def initialize(user, mailbox = 'inbox')
    self.user = user
    self.mailbox = mailbox
    
    Mail.defaults do
      retriever_method :pop3, {
                                :address => "pop.gmail.com", 
                                :port => 995, 
                                :user_name => user.email, 
                                :password => user.password, 
                                :enable_ssl => true 
                              }
    end
    
  end
  
  def get_emails
    Mail.all
  end
  
end