module VkMusicLoader
  class Authorizer
    AUTH_FILE_PATH = File.expand_path('~') + '/.vk_auth_data'

    def initialize(app_id)
      @app_id = app_id
    end

    def perform
      get_auth_token
    end

    private

    attr_reader :app_id

    def get_auth_params_from_browser_bar
      Launchy.open("https://oauth.vk.com/authorize?client_id=#{app_id}&scope=audio&redirect_uri=http://oauth.vk.com/blank.html&display=page&response_type=token")
      ARGV.clear
      puts 'Paste full URL from browser bar and press ENTER: '
      CGI.parse(URI(gets.chomp.strip).fragment)
    end

    def save_auth_params_to_file
      auth_params = get_auth_params_from_browser_bar
      auth_file = File.open(AUTH_FILE_PATH, 'w')
      auth_file.puts(Time.new + auth_params['expires_in'].first.to_i)
      auth_file.puts(auth_params['access_token'].first)
      auth_file.puts(auth_params['user_id'].first)
      auth_file.close
    end

    def get_auth_params_from_file
      auth_file = File.open(AUTH_FILE_PATH, 'r')

      expires_in = auth_file.readline
      access_token = auth_file.readline.chomp
      auth_file.close

      access_token if Time.parse(expires_in) > Time.new
    end

    def get_auth_token
      begin
        auth_token = get_auth_params_from_file
        unless auth_token.nil?
          auth_token
        else
          raise 'The validity of the token has expired'
        end
      rescue
        save_auth_params_to_file
        retry
      end
    end
  end
end
