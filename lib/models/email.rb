class Email
  include Mongoid::Document
  
  embedded_in :user, :inverse_of => :emails
  
  field :message_id
  field :date
  field :subject
  field :to, :type => Array
  field :subject, :type => Binary
  field :from, :type => Array
  
  def self.find_by_message_id(message_id)
    where(:message_id => message_id).first
  end
  
  def self.order_by_date(message_id)
    order_by(:date.desc)
  end
  
end