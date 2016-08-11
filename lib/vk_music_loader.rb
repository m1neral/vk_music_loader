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
  def self.call
    begin
      opts = Slop.parse uppress_errors: true do |o|
        o.integer 'app', '-app', '--app', '-application', '-application', default: 5377636 # author's application (you can use it)
        o.integer 'id', '-id', '--id', '-user-id', '--user-id', '-group-id', '--group-id'
        o.string 'folder', '-folder', '--folder', 'path', '-path', '--path', default: 'audio'
      end

      if opts.id?
        auth_token = VkMusicLoader::Authorizer.new(opts[:app]).perform
        VkMusicLoader::SongsDownloader.new(auth_token, opts[:id], opts[:folder]).perform
      else
        puts 'No user id or group id'
      end
    rescue Slop::Error => e
      puts e.message
    end
  end
end
