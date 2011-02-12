get '/emails/:id/contacts/new' do |email_id|
  adapter = GmailAdapter.new(current_user, 'inbox')
  @email = Email.find(email_id)
  @contacts = Contact.set_checked_contacts(@email.to)
  haml :'contacts/contacts'
end

post '/emails/:id/contacts' do |email_id|
  params[:contacts].each do |contact|
    unless Contact.where(:email => contact).first
      Contact.create :email => contact
    end
  end
  
  redirect "/emails/#{email_id}/contacts/new"
end