get '/emails/:id/contacts/new' do |email_id|
  adapter = GmailAdapter.new(current_user, 'inbox')
  @email = current_user.emails.find(email_id)
  @contacts = Contact.set_checked_contacts(@email.from)
  haml :'contacts/contacts'
end

post '/emails/:id/contacts' do |email_id|
  params[:contacts].each do |contact|
    unless current_user.contacts.where(:email => contact).first
      current_user.contacts << Contact.new(:email => contact)
      current_user.save
    end
  end
  
  redirect "/emails/#{email_id}/contacts/new"
end