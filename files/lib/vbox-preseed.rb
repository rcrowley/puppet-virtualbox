# Usage: ruby vbox-preseed.rb <dirname>
#   <dirname> directory containing preseed file(s)

require 'webrick'

server = WEBrick::HTTPServer.new({
  :BindAddress => "0.0.0.0",
  :DocumentRoot => ARGV[0],
  :Port => 48879,
})
["INT", "QUIT", "TERM"].each do |signal|
  trap signal do
    server.shutdown
  end
end
server.start
