require 'yaml'

require_relative '../keychain'

module ThingsFetcher
  class Config
    def initialize(path)
      super

      @data = default_config
      @data.merge! load_from_file(path)
    end
    
    def [](key)
      data.has_key?(key) ? data[key] : send(key.to_s)
    end
    
    def password
      KeyChain.find_internet_password '-s', data[:server], '-a', data[:username]
    end
    
    private
      attr_accessor :data
    
      def default_config
        {
          :server => 'imap.gmail.com',
          :port => 993,
          :ssl => true,
          :use_login => true,
          :in_folder => 'Things',
          :error_folder => 'Things',
          :tag_names => 'Texted',
          :list => 'Inbox'
        }        
      end
      
      def load_from_file(path)
        expanded_path = File.expand_path(path)
        if File.exists?(expanded_path)
          loaded_config = YAML::load(File.open(expanded_path))
          result = {}
          config_keys.each do |k|
            if loaded_config.has_key?(k.to_s)
              result[k] = loaded_config[k.to_s]
            end
          end
          if result.has_key?(:username)
            result
          else
            puts "ERROR: No username specified in the config."
            puts "       Please edit the config file at: #{expanded_path}"
            exit 0
          end
        else
          generate_config_file(expanded_path)
          puts "ERROR: No config file found at: #{expanded_path}"
          puts "       A new config has been generated."
          puts "       Please edit."
          exit 0
        end
      end
      
      def config_keys
        [ 
          :server, 
          :port, 
          :ssl, 
          :use_login, 
          :in_folder,
          :error_folder, 
          :tag_names, 
          :list, 
          :username, 
          :password 
        ]        
      end
      
      def generate_config_file(path)
        File.open(path, "w") do |f|
          f << <<-EOS
# The IP address or domain name of the IMAP server
server: imap.gmail.com

# The port to connect to (defaults to the standard port for the type of server)
port: 993

# Set to any value to use SSL encryption
ssl: true

# Set to any value to use the LOGIN command instead of AUTHENTICATE. 
# Some servers, like GMail, do not support AUTHENTICATE (IMAP only).
use_login: true

# The username to authenticate with.
# Uncoment and edit the following line.
# username: email@domain.com

# The password to authenticate with.
# Leave the following line commented out to you the password stored in the Keychain.
# Uncomment and edit otherwise.
# password: somepassword

# The name of the folder from which to read incoming mail (IMAP only). Defaults to INBOX.
in_folder: Things

# The name a folder to move mail that causes an error during processing (IMAP only). 
error_folder: Things

# The tags to apply to the newly created TODOs.
tag_names: Texted

# The list in Things to create TODOs in.
list: Inbox
EOS
        end
      end
  end
end