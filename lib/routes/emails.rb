get '/emails' do
  #cache 'amazon', :expiry => 10, :compress => true do
    adapter = GmailAdapter.new(current_user, 'inbox')
    current_user.store_new_emails(adapter.get_emails)
    @emails = current_user.emails
    haml :'emails/index', {:layout => :layout}
  #end
end