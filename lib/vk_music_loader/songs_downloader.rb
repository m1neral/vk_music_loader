module VkMusicLoader
  class SongsDownloader
    API_AUDIO_METHOD_PATHS = {
        get: 'https://api.vk.com/method/audio.get',
        search: 'https://api.vk.com/method/audio.search'
    }

    QUERY_PARAMS = {
        v: '5.53'
    }

    def initialize(auth_token, opts)
      @auth_token = auth_token
      @opts = opts
    end

    def perform
      raw_playlist = get_raw_playlist

      if raw_playlist['error']
        puts raw_playlist['error']['error_msg']
      else
        download_songs(get_milled_playlist(raw_playlist))
      end
    end

    private

    attr_reader :auth_token, :opts

    def query_params
      merged_query_params = QUERY_PARAMS.merge(access_token: auth_token)
      merged_query_params[:owner_id] = opts[:id] unless opts[:query]
      merged_query_params[:q] = opts[:query] unless opts[:id]

      if opts[:random]
        merged_query_params[:count] = 300
      elsif opts[:count]
        merged_query_params[:count] = opts[:count]
      end

      merged_query_params
    end

    def audio_method_path
      if opts[:id]
        API_AUDIO_METHOD_PATHS[:get]
      elsif opts[:query]
        API_AUDIO_METHOD_PATHS[:search]
      end
    end

    def build_uri
      uri = URI(audio_method_path)
      uri.query = URI.encode_www_form(query_params)
      uri
    end

    def build_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end

    def get_raw_playlist
      uri = build_uri
      req = Net::HTTP::Get.new(uri)
      res = build_http(uri).request(req)

      JSON.parse(res.body)
    end

    def get_milled_playlist(raw_playlist)
      songs = raw_playlist['response']['items']
      songs_count = opts[:count] || songs.count

      opts[:random] ? songs.sample(songs_count) : songs
    end

    def download_songs(playlist)
      Dir.mkdir(opts[:folder]) unless File.exists?(opts[:folder])

      downloads_count = 0

      playlist.each do |song|
        song_url = URI.parse(song['url'])
        file_name = "#{song['artist']} - #{song['title']}".slice(0, 100).gsub(/[\x00\/\\:\*\?\"<>\|]/, '_') + '.mp3'
        file_path = "#{opts[:folder]}/#{file_name}"

        unless File.file?(file_path)
          File.open(file_path, 'w') do |f|
            f.write Net::HTTP.get(song_url)
            f.close

            downloads_count += 1
            puts "Downloaded: #{file_name}"
          end
        end
      end

      puts "-----> Downloaded #{downloads_count} songs in #{opts[:folder]}"
      puts "-----> The other #{playlist.count - downloads_count} songs have been already downloaded" if
          playlist.count - downloads_count > 0
    end
  end
end
