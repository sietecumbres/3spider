get '/emails/:id/contacts/new' do |email_id|
  adapter = GmailAdapter.new(current_user, 'inbox')
  @email = current_user.emails.find(email_id)
  @contacts = current_user.set_checked_contacts(@email.emails_list)
  @contacts ||= []
  haml :'contacts/contacts'
end

post '/emails/:id/contacts' do |email_id|
  params[:contacts].each do |contact|
    unless current_user.contacts.where(:email => contact).first
      AmazonSESAdapter.verify_address(contact)
      current_user.contacts << Contact.new(:email => contact)
      current_user.save
    end
  end
  
  redirect "/emails"
end