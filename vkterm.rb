require 'termcolor';
require 'vk-ruby'

require './config.rb'

#puts TermColor.parse('<blue>Hello</blue> <red>World!</red>')
settings = Config.instance.vk_settings

def auth_url

url = app.authorization_url({
  type: :client,
  app_id: settings[:app_id],
  settings: 'messages,friends',
  redirect_uri: 'http://localhost:3000',
  display: :mobile
})

end

app = VK::Application.new(app_id: settings['app_id'], version: settings['version'], access_token: settings['access_token'])

#messages = app.vk_call 'messages.get', {count: 20}
#user_ids = messages["items"].map { |u| u['id'] }.uniq

#users = app.vk_call 'users.get', {fields: 'id, first_name, last_name', user_ids: user_ids.join(',')}
#puts messages
#puts users


dialogs = app.vk_call 'messages.getDialogs', {count: 5}
dialog_messages = dialogs["items"].map { |d| d['message'] }

peer_ids = dialog_messages.map { |m| m['user_id'] }.uniq

peers = app.vk_call 'users.get', {fields: 'id, first_name, last_name', user_ids: peer_ids.join(',')}

peer_names = peers.map {|p| [p['id'], "#{p['first_name']} #{p['last_name']}"] }.to_h

output = dialog_messages.map { |m| "#{ peer_names[m['user_id']]  }: #{ m['body'].rjust(100)  }"}

puts output.reverse.join "\n"