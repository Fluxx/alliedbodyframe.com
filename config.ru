use Rack::Static , :urls => { "/" => "index.html" }
run Rack::URLMap.new("/" => Rack::Directory.new("."))