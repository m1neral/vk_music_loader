module VKMusic
  class SongsDownloader
    USER_ID = 11155153 # or group_id with '-', whose playlist will be downloaded (if not private)
    AUDIO_FOLDER_NAME = 'audio'

    def initialize(auth_token)
      @auth_token = auth_token
    end

    def perform
      download_songs(get_playlist(auth_token))
    end

    private

    attr_reader :auth_token

    def get_playlist(auth_token)
      http = Net::HTTP.new('api.vk.com', 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new("https://api.vk.com/method/audio.get?owner_id=#{USER_ID}&v=5.50&access_token=#{auth_token}")
      res = http.request(req)

      JSON.parse(res.body)
    end

    def download_songs(playlist)
      Dir.mkdir(AUDIO_FOLDER_NAME) unless File.exists?(AUDIO_FOLDER_NAME)

      songs = playlist['response']['items']

      songs.each do |song|
        song_url = URI.parse(song['url'])
        file_name = "#{song['artist']} - #{song['title']}.mp3"
        file_path = "#{AUDIO_FOLDER_NAME}/#{file_name}"

        unless File.file?(file_path)
          File.open(file_path, 'w') do |f|
            f.write Net::HTTP.get(song_url)
            f.close

            puts "Downloaded: #{file_name}"
          end
        end
      end
    end
  end
end
