require 'rubygems'
require 'time'
require 'launchy'
require 'cgi'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

require './vkmusic/authorizer'
require './vkmusic/songs_downloader'

VKMusic::SongsDownloader.new(VKMusic::Authorizer.new.perform).perform