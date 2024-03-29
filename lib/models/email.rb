class Email
  include Mongoid::Document
  
  embedded_in :user, :inverse_of => :emails
  
  field :message_id
  field :date, :type => Date
  field :subject
  field :subject, :type => Binary
  field :emails_list, :type => Array
  field :from
  
  scope :ordered, descending(:date)
  
  def self.find_by_message_id(message_id)
    where(:message_id => message_id).first
  end
  
end