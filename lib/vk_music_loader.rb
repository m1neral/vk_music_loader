require 'vk_music_loader/version'

require 'rubygems'
require 'time'
require 'cgi'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'slop'
require 'launchy'

require 'vk_music_loader/authorizer'
require 'vk_music_loader/songs_downloader'

module VkMusicLoader
  def self.call(opts)
    auth_token = Authorizer.new(opts[:app]).perform
    SongsDownloader.new(auth_token, opts[:id], opts[:folder]).perform
  end
end
