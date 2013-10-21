require 'sinatra'
require 'digest'
require 'uri'
require 'json'
require 'fileutils'
require 'logger'

class NTMServer < Sinatra::Application

  get '/pictures/:identifier' do
    content_type :json
    identifier = params[:identifier]
    listing = Dir.entries(File.join(File.dirname(__FILE__), 'uploads/ipad' + identifier)).select do |filename|
      filename[0].chr != '.'
    end
    return listing.to_json
#    send_file File.join('uploads/ipad' + identifier, filename)
  end

  get '/pictures/:identifier/:filename' do
    identifier = params[:identifier]
    filename = params[:filename]
    send_file File.join('uploads/ipad' + identifier, filename)
  end

  post '/pictures/:identifier/:filename' do
    #content_type 'multipart/form-data'
    #identifier = params[:identifier]
    #filename = params[:filename]
    #
    #unless (params[filename][:tempfile].nil? and data['content_type']) then
    #  File.open(File.join('uploads/ipad' + identifier, filename), 'wb') do |f|
    #    f.write(params[filename][:tempfile].read)
    #    f.close
    #  end
    #  return 'The file was successfully uploaded!'
    #else
    #  status 404
    #  return {'message' => 'Error: provide a valid file'}.to_json
    #end

    identifier = params[:identifier]
    tempfile   = params[:file][:tempfile]
    filename   = params[:filename]

    unless filename.nil? then
      filename = File.join("uploads/ipad" + identifier, filename)
      File.open(filename, 'wb') do |file|
        file.write(tempfile.read)
      end
      return {:fileSaved => filename}.to_json
      status 200;
    end

  end

end