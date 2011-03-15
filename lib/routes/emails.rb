get '/emails' do
  begin
    adapter = GmailAdapter.new(current_user, 'inbox')
    current_user.store_new_emails(adapter.get_emails)
  
    emails = current_user.emails.paginate(:per_page => 50, :page => params[:page])
    @emails = emails.sort{|x, y| y.date <=> x.date}
  
    haml :'emails/index', {:layout => :layout}
  rescue
    flash[:notice] = 'Usuario o contraseña erroneas'
    redirect '/login'
  end
end

get '/emails/new' do
  haml :'emails/new', {:layout => :layout}
end

post '/emails' do
  send_email(current_user, 'test', :'emails/email')
end