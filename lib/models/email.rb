class Email
  include Mongoid::Document
  
  field :message_id
  field :date
  field :subject
  field :from, :type => Array
  
  def self.store_new_emails(emails)
    emails.each do |email|
      create(:subject => email.subject, :date => email.date, :message_id => email.message_id, :from => email.from)
    end
  end
  
  def self.find_by_message_id(message_id)
    where(:message_id => message_id).first
  end
  
end