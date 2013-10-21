root = ::File.dirname(__FILE__)
require ::File.join( root, 'server' )
require './env' if File.exists?('env.rb')
run NTMServer.new