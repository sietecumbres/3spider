get '/emails' do
  #cache 'amazon', :expiry => 10, :compress => true do
    adapter = GmailAdapter.new(current_user, 'inbox')
    Email.store_new_emails(adapter.get_emails)
    @emails = Email.all
    haml :'emails/index', {:layout => :layout}
  #end
end