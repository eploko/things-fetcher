require 'appscript'
require 'mail'
require 'osax'

module ThingsFetcher
  class MailHandler
    def initialize(config)
      @config = config
    end
    
    def receive(data)
      msg = Mail.read_from_string(data)
      make_todo msg.subject
    end
  
    private
      include Appscript
      include OSAX
      
      attr_accessor :config
  
      def make_todo(name)
        things = app("Things")
        todo = things.make(:new => :to_do, :at => things.lists[config[:list]], :with_properties => { :name => name })
        todo.tag_names.set config[:tag_names]
      end
  end
end
