$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/lib')
require 'restclient'

use Rack::ShowExceptions

use Rack::Auth::Basic do |username, password|
  if @ins[2].env
    # pp @ins[2].env['PATH_INFO'].split('/')[1]
    begin
      resp = RestClient.get "https://#{username}:#{password}@dashboard.pagodabox.com/apps/#{@ins[2].env['PATH_INFO'].split('/')[1]}.json", headers: { accept: :json }
      true
    rescue Exception => e
      false
    end
  else
    begin
      resp = RestClient.get "https://#{username}:#{password}@dashboard.pagodabox.com/apps.json", headers: { accept: :json }
      true      
    rescue Exception => e
      false
    end
  end
end

require 'git_http'

config = {
  :project_root => "/Users/lyon/test/git",
  :git_path => '/usr/local/bin/git',
  :upload_pack => true,
  :receive_pack => true,
}

run GitHttp::App.new(config)
