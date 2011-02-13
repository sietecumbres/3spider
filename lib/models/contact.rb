class Contact
  include Mongoid::Document
  
  embedded_in :user, :inverse_of => :contacts
  
  field :email
  
  attr_accessor :checked
  
end