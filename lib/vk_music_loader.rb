require 'vk_music_loader/version'

require 'rubygems'
require 'time'
require 'cgi'
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'slop'

require 'vk_music_loader/authorizer'
require 'vk_music_loader/songs_downloader'

module VkMusicLoader
  def self.call
    begin
      opts = Slop.parse uppress_errors: true do |o|
        o.string 'key', '-key', '--key', '-k'
        o.integer 'id', '-id', '--id', '-user-id', '--user-id', '-group-id', '--group-id'
        o.string 'query', '-query', '--query', '-q', 'search', '-search', '--search'
        o.integer 'count', '-count', '--count', 'c', '-c', '--c'
        o.string 'folder', '-folder', '--folder', 'path', '-path', '--path', '-p', default: 'audio'
        o.bool 'random', '-random', '--random', 'shuffle', '-shuffle', '--shuffle', '-r'
      end

      if opts[:id] || opts[:query]
        auth_token = VkMusicLoader::Authorizer.new(opts[:key]).perform
        VkMusicLoader::SongsDownloader.new(auth_token, opts).perform
      else
        puts 'No user id or group id or query'
      end
    rescue Slop::Error => e
      puts e.message
    end
  end
end
