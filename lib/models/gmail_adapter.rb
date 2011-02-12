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
    #Gmail.new(self.user.email.to_s, self.user.password.to_s).inbox.emails
    #self.default_mailbox(mailbox).emails
    Mail.all
  end
  
  def default_mailbox(mailbox = 'inbox')
    @mailbox = self.gmail_login.in_label(mailbox)
  end
  
  def gmail_login
    @gmail ||= Gmail.new(self.user.email.to_s, self.user.password.to_s) if self.user
  end
  
end