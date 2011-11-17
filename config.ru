use Rack::Static, :urls => { "/" => "index.html" }
run Rack::Directory.new(".")