module VkMusicLoader
  class SongsDownloader
    API_AUDIO_METHOD_PATH = 'http://api.xn--41a.ws/api.php'

    QUERY_PARAMS = {
        by_owner: {
            method: 'by_owner'
        },
        search: {
            method: 'search'
        },
        get: {
            method: 'get.audio'
        }
    }

    SONGS_LIMIT = 300
    SONGS_LIMIT_REQUEST = 10

    def initialize(auth_key, opts)
      @auth_key = auth_key
      @opts = opts
    end

    def perform
      get_songs_urls_and_download(get_playlist)
    end

    private

    attr_reader :opts, :auth_key

    def build_query_params_for_ids
      merged_query_params = audio_method_params
      merged_query_params[:owner_id] = opts[:id] unless opts[:query]
      merged_query_params[:q] = opts[:query] unless opts[:id]
      merged_query_params[:key] = auth_key

      merged_query_params
    end

    def build_query_params_for_urls(songs_ids_list)
      merged_query_params = QUERY_PARAMS[:get]
      merged_query_params[:ids] = songs_ids_list.join(',')
      merged_query_params[:key] = auth_key

      merged_query_params
    end

    def audio_method_params
      if opts[:id]
        QUERY_PARAMS[:by_owner]
      elsif opts[:query]
        QUERY_PARAMS[:search]
      end
    end

    def build_uri(query_params)
      uri = URI(API_AUDIO_METHOD_PATH)
      uri.query = URI.encode_www_form(query_params)
      uri
    end

    def build_http(uri)
      Net::HTTP.new(uri.host, uri.port)
    end

    def get_playlist
      uri = build_uri(build_query_params_for_ids)

      req = Net::HTTP::Get.new(uri)
      res = build_http(uri).request(req)

      begin
        JSON.parse(res.body)
      rescue
        abort('Perhaps a user or group with such id does not exist')
      end
    end

    def get_songs_urls_and_download(raw_playlist)
      songs_ids_list = raw_playlist['list'].map { |song_info| "#{song_info[1]}_#{song_info[0]}" }
      filtered_songs_ids_list = filter_playlist(songs_ids_list)

      Dir.mkdir(opts[:folder]) unless File.exists?(opts[:folder])
      final_downloads_count = 0

      filtered_songs_ids_list.each_slice(SONGS_LIMIT_REQUEST) do |ids|
        query_params = build_query_params_for_urls(ids)

        uri = build_uri(query_params)
        req = Net::HTTP::Get.new(uri)
        res = build_http(uri).request(req)

        begin
          final_downloads_count += download_songs(JSON.parse(res.body)
            .map { |song_info| { url: song_info[2], title: song_info[3], artist: song_info[4] } })
        rescue JSON::ParserError
          puts 'Some songs download failed'
        end
      end

      puts "-----> Downloaded #{final_downloads_count} songs in #{opts[:folder]}"
      puts "-----> The other #{filtered_songs_ids_list.count - final_downloads_count} songs have been already downloaded" if
          filtered_songs_ids_list.count - final_downloads_count > 0
    end

    def filter_playlist(playlist)
      if !opts[:random] && opts[:count]
        playlist.take(opts[:count])
      elsif opts[:random] && !opts[:count]
        playlist.sample(SONGS_LIMIT)
      elsif opts[:random] && opts[:count]
        playlist.sample(opts[:count])
      else
        playlist
      end
    end

    def download_songs(playlist)
      playlist.inject(0) do |count, song|
        song_url = URI.parse(song[:url])
        file_name = "#{song[:artist]} - #{song[:title]}".slice(0, 100).gsub(/[\x00\/\\:\*\?\"<>\|]/, '_') + '.mp3'
        file_path = "#{opts[:folder]}/#{file_name}"

        unless File.file?(file_path)
          File.open(file_path, 'w') do |f|
            f.write Net::HTTP.get(song_url)
            f.close

            puts "Downloaded: #{file_name}"
            count += 1
          end
        end

        count
      end
    end
  end
end
