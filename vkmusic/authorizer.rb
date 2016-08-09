module VKMusic
  class Authorizer
    APP_ID = 5377636 # author's application (you can use it)
    AUTH_FILE_NAME = '.vk_auth_data'

    def perform
      get_auth_token
    end

    private

    def get_auth_params_from_browser_bar
      Launchy.open("https://oauth.vk.com/authorize?client_id=#{APP_ID}&scope=audio&redirect_uri=http://oauth.vk.com/blank.html&display=page&response_type=token")
      puts 'Paste full URL from browser and press ENTER: '
      CGI.parse(URI(gets.chomp.strip).fragment)
    end

    def save_auth_params_to_file
      auth_params = get_auth_params_from_browser_bar
      auth_file = File.open(AUTH_FILE_NAME, 'w')
      auth_file.puts(Time.new + auth_params['expires_in'].first.to_i)
      auth_file.puts(auth_params['access_token'].first)
      auth_file.puts(auth_params['user_id'].first)
      auth_file.close
    end

    def get_auth_params_from_file
      auth_file = File.open(AUTH_FILE_NAME, 'r')

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
