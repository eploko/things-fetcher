require_relative '../fetcher'
require_relative 'mail_handler'

module ThingsFetcher
  class Fetcher
    def initialize(config)
      super
      @config = config
    end
    
    def run
      fetcher = ::Fetcher.create(fetcher_options)
      fetcher.fetch
    end
    
  private
    attr_accessor :config
  
    def fetcher_options
      {
        :type => :imap,
        :receiver => handler,
        :server => config[:server],
        :port => config[:port],
        :ssl => config[:ssl],
        :use_login => config[:use_login],
        :username => config[:username],
        :password => config[:password],
        :in_folder => config[:in_folder],
        :error_folder => config[:error_folder]
      }      
    end
    
    def handler
      ThingsFetcher::MailHandler.new(config)      
    end
  end
end
