module VkMusicLoader
  class SongsDownloader
    def initialize(auth_token, user_id, audio_folder_path)
      @auth_token = auth_token
      @user_id = user_id
      @audio_folder_path = audio_folder_path
    end

    def perform
      download_songs(get_playlist(auth_token))
    end

    private

    attr_reader :auth_token, :user_id, :audio_folder_path

    def get_playlist(auth_token)
      http = Net::HTTP.new('api.vk.com', 443)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get.new("https://api.vk.com/method/audio.get?owner_id=#{user_id}&v=5.50&access_token=#{auth_token}")
      res = http.request(req)

      JSON.parse(res.body)
    end

    def download_songs(playlist)
      Dir.mkdir(audio_folder_path) unless File.exists?(audio_folder_path)

      songs = playlist['response']['items']

      songs.each do |song|
        song_url = URI.parse(song['url'])
        file_name = "#{song['artist']} - #{song['title']}.mp3".gsub(/[\x00\/\\:\*\?\"<>\|]/, '_')
        file_path = "#{audio_folder_path}/#{file_name}"

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
