class Contact
  include Mongoid::Document
  
  field :email
  
  attr_accessor :checked
  
  
  
  def self.set_checked_contacts(contacts_list)
    contacts_list.collect do |contact|
      
      if c = Contact.where(:email => contact).first
        c.checked = 'checked'
      else
        c = Contact.new :email => contact
      end
      
      c
    end
  end
  
end