module VkMusicLoader
  class Authorizer
    AUTH_FILE_PATH = File.expand_path('~') + '/.vk_music_loader/auth_data'

    API_CHECK_AUDIO_METHOD_PATH = 'http://api.xn--41a.ws/api.php'

    def initialize(auth_key = nil)
      @auth_key = auth_key
    end

    def self.auth_key_valid?(auth_key)
      uri = URI(API_CHECK_AUDIO_METHOD_PATH)
      uri.query = URI.encode_www_form(key: auth_key, method: :by_owner, owner_id: :dummy)

      req = Net::HTTP::Get.new(uri)
      res = Net::HTTP.new(uri.host, uri.port).request(req)

      res.body != 'wrong key' && res.body != 'key wrong format'
    end

    def perform
      get_auth_token
    end

    private

    attr_reader :auth_key

    def save_auth_params_to_file(auth_key)
      dir_path = File.dirname(AUTH_FILE_PATH)
      Dir.mkdir(dir_path) unless File.exists?(dir_path)

      auth_file = File.open(AUTH_FILE_PATH, 'w')
      auth_file.puts(auth_key)
      auth_file.close
    end

    def get_auth_params_from_file
      begin
        auth_file = File.open(AUTH_FILE_PATH, 'r')

        auth_key = auth_file.readline.chomp
        auth_file.close

        auth_key
      rescue
        nil
      end
    end

    def get_auth_token
      auth_token = auth_key || get_auth_params_from_file

      unless auth_token.nil?
        if Authorizer.auth_key_valid?(auth_token)
          save_auth_params_to_file(auth_token)
          auth_token
        else
          abort('Invalid authentication key')
        end
      else
        abort('No authentication key')
      end
    end
  end
end
