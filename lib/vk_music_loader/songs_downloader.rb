module VkMusicLoader
  class SongsDownloader
    API_AUDIO_GET_PATH = 'https://api.vk.com/method/audio.get'
    QUERY_PARAMS = {
        v: '5.50'
    }

    def initialize(auth_token, user_id, audio_folder_path)
      @auth_token = auth_token
      @user_id = user_id
      @audio_folder_path = audio_folder_path
    end

    def perform
      playlist = get_playlist

      if playlist['error']
        puts playlist['error']['error_msg']
      else
        download_songs(playlist)
      end
    end

    private

    attr_reader :auth_token, :user_id, :audio_folder_path

    def query_params
      QUERY_PARAMS.merge(owner_id: user_id, access_token: auth_token)
    end

    def build_uri
      uri = URI(API_AUDIO_GET_PATH)
      uri.query = URI.encode_www_form(query_params)
      uri
    end

    def build_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def get_playlist
      uri = build_uri
      req = Net::HTTP::Get.new(uri)
      res = build_http(uri).request(req)

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
