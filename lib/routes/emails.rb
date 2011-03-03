get '/emails' do
  limit = 20
  page = (params[:page] || 1).to_i
  offset = limit * (page -1)

  adapter = GmailAdapter.new(current_user, 'inbox')
  current_user.store_new_emails(adapter.get_emails)
  
  emails = current_user.emails.all :limit => limit, :offset => offset
  emails = emails.sort{|x, y| y.date <=> x.date}
  @emails = WillPaginate::Collection.create(page, limit, current_user.emails.count){|p| p.replace emails}
  
  haml :'emails/index', {:layout => :layout}
end

get '/emails/new' do
  haml :'emails/new', {:layout => :layout}
end

post '/emails' do
  send_email(current_user, 'test', :'emails/email')
end