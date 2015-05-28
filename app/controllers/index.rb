get '/' do
  erb :index
end

get '/entries' do
  @entries = Entry.all
  erb :"entries/show"
end

post '/entries' do
  entry = Entry.create(params[:entry])
  if request.xhr?
    content_type :json
    {form: erb(:"entries/_create_entry_partial", layout: false, locals: {entry: entry})}.to_json
  else
    redirect "/entries"
  end
end

get '/entries/:entry_id' do
  @entry = Entry.find(params[:entry_id])
  @tags = @entry.tags
  erb :"entries/single_entry"
end

post '/entries/:entry_id/tags' do
  @entry = Entry.find(params[:entry_id])
  @tag = @entry.tags.find_or_create_by(params[:tag])
  if request.xhr?
    content_type :json
    {form: erb(:"tags/_create_tag_partial", locals: {tag: @tag})}.to_json
  else
    redirect "/entries/#{@entry.id}"
  end
end

get '/entries/:entry_id/tags/:tag_id' do
  @entry = Entry.find(params[:entry_id])
  @tag = Tag.find(params[:tag_id])
  erb :"tags/single_tag"
end

delete '/entries/:entry_id/tags/:tag_id' do
  @entry = Entry.find(params[:entry_id])
  @tag = Tag.find(params[:tag_id])
  tagging = @entry.taggings.find_by(tag_id: @tag.id)
  tagging.destroy
  redirect "/entries/#{@entry.id}"
end

get '/entries/:entry_id/edit' do
  @entry = Entry.find(params[:entry_id])
  erb :"entries/edit"
end

put '/entries/:entry_id' do
  entry = Entry.find(params[:entry_id])
  entry.update_attributes(params[:entry])
  if request.xhr?
    content_type :json
    {entry: entry.content}.to_json
  else
    redirect "/entries/#{@entry.id}"
  end
end

delete '/entries/:entry_id' do
  @entry = Entry.find(params[:entry_id])
  link = @entry.id
  @entry.destroy
  if request.xhr?
    content_type :json
    {link: link}.to_json
  else
    redirect "/entries"
  end
end
