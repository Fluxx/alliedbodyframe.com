require "rack"
require "rack-rewrite"

ENV['RACK_ENV'] ||= 'development'
ENV['SITE_URL'] ||= 'www.alliedbodyframe.com'

use Rack::Rewrite do

  r301 %r{.*}, "http://#{ENV['SITE_URL']}$&", :if => Proc.new { |rack_env|
    ENV['RACK_ENV'] == 'production' && rack_env['SERVER_NAME'] != ENV['SITE_URL']
  }

  r301 %r{^(.+)/$}, '$1'

  %w[about contact work].each do |path|
    r301 "/#{path}", "#{path}.html"
  end
end

use Rack::Static , :urls => { "/" => "index.html" }
run Rack::URLMap.new("/" => Rack::Directory.new(File.dirname(__FILE__)))