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
        list = []
        list.concat(email.from) if email.from
        list.concat(email.to) if email.to
        self.emails << Email.new(:subject => ic.iconv(email.subject), :date => email.date, :message_id => email.message_id, :emails_list => list)
        save
      end
    end
  end
  
  def set_checked_contacts(contacts_list)
    contacts_list.collect do |contact|
      
      if c = self.contacts.where(:email => contact).first
        c.checked = 'checked'
      else
        c = Contact.new :email => contact
      end
      
      c
    end if contacts_list
  end
  
end