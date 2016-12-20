require 'json'
require 'open-uri'

module Hypixel

  class Requester

    def initialize(api)
      @api = api
    end

    # Arguments: method
    # Options: params options
    #
    # Constructs a structured hash based off supplied arguments.
    # If args[:options][:async] is specified, it will spawn a thread to handle the request.
    # If not, the request will be blocking.
    #
    # Method it the request to be made, such as 'findGuild' and 'playerCount'.
    #
    # Requires a block to be provided.
    # Requires :method to be provided.
    def make_request(args = {})
      unless args.has_key? :method
        raise ArgumentError, 'Missing method!'
      end
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      args[:options] ||= {}
      args[:options][:async] = false if args[:options][:async].nil?
      args[:options][:anonymous] = false if args[:options][:anonymous].nil?
      args[:options][:join] = false if args[:options][:join].nil?
      args[:params] ||= {}

      unless args[:options][:anonymous]
        args[:params][:key] = @api.api_key
      end

      if args[:options][:async]
        thread = Thread.new {
          yield send_request(args)
        }

        if args[:options][:join]
          thread.join
        end
      else
        yield send_request(args)
      end
    end

    private

    # Constructs a URI, formats any parameters and sends the request.
    # It then parses the response as JSON and returns.
    #
    # Params:
    # +args+::Parameters to be formatted in the GET request.
    def send_request(args)
      uri = URI.parse "https://api.hypixel.net/#{args[:method]}"

      if args[:params].length > 0
        uri.query = URI.encode_www_form args[:params]
      end

      response = uri.open.read

      JSON.parse(response)
    end
  end
end
