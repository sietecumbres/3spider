class User
  include Mongoid::Document
  
  embeds_many :emails
  embeds_many :contacts
  
  field :email
  
  attr_accessor :password
  
  def self.find_by_email(email)
    where(:email => email).first
  end
  
  def store_new_emails(emails)
    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
    emails.each do |email|
      begin
        self.emails << Email.new(:subject => ic.iconv(email.subject), :date => email.date, :message_id => email.message_id, :from => email.from)
        save
      end
    end
  end
  
end