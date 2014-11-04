require 'logger'
require 'open-uri'
require 'json'

module Hypixel

    class API

        attr_reader :apiKey

        def initialize(apiKey)
            @apiKey = apiKey
            @logger = Logger.new STDOUT

            @logger.formatter = proc do | severity, datetime, prognam, msg |
                "[#{severity} #{datetime}] #{msg}\n"
            end
        end

        # Returns an Array of Friend instances consisting of the Player's friends list.
        #
        # Params:
        # +username+::Username to find Friends of.
        def friends_by_username(username)
            @logger.info "Looking up friends by username [#{username}]"

            request = make_request('friends', {
                :player => username
            })

            friends = Array.new

            if request.has_key? 'records'
                request['records'].each do | record |
                    friends << Friend.from_json(record)
                end
            end

            friends
        end

        # Returns a JSON object concerning the Guild.
        # Retrieved using the Guild's ID.
        #
        # Calls API method "guild"
        #
        # Params:
        # +id+::The ID of the Guild.
        def guild_by_id(id)
            @logger.info "Looking up guild by id [#{id}]"

            request = make_request('guild', {
                :id => id
            })

            Guild.from_json request
        end

        # Looks up the guild's id using the provided name and then returns the result of guild_by_id.
        # Due to it's nature, this runs two queries.
        #
        # Calls API method "findGuild"
        #
        # Params:
        # +name+::The name of the Guild.
        def guild_by_name(name)
            @logger.info "Looking up guild by name [#{name}]"

            id = make_request('findGuild', {
                :byName => name
            })['guild']

            guild_by_id id
        end

        # Looks up the guild's id using the provided member and then returns the result of guild_by_id.
        # Due to it's nature, this runs two queries.
        #
        # Calls API method "findGuild"
        #
        # Params:
        # +username+::The username of a member of the Guild.
        def guild_by_member(username)
            @logger.info "Looking up guild by member [#{username}]"

            id = make_request('findGuild', {
                :byPlayer => username
            })['guild']

            guild_by_id id
        end

        # Returns a JSON object concerning the player. Retrieved using the username.
        #
        # Calls API method "player"
        #
        # Params:
        # +username+::Using a UUID is preferred to make sure you get the desired player.
        def player_by_username(username)
            @logger.info "Looking up player by username [#{username}]"

            request = make_request('player', {
                :name => username
            })

            Player.from_json request
        end

        # Returns a JSON object concerning the player. Retrieved using the UUID.
        #
        # Calls API method "player"
        #
        # Params:
        # +uuid+::The player's UUID. This should NOT contain dashes.
        def player_by_uuid(uuid)
            @logger.info "Looking up player by UUID [#{uuid}]"

            request = make_request('player', {
                :uuid => uuid
            })

            Player.from_json request
        end

        private

        # Automatically generates and executes a request given the type and parameters.
        #
        # Params:
        # +type+::The API method being called. Tends to be a magic value.
        # +params+::Request parameters, the API key is automagically apended to this array.
        def make_request(type, params)
            params[:key] = apiKey

            uri = URI.parse "https://api.hypixel.net/#{type}"
            uri.query = URI.encode_www_form params

            JSON.parse uri.open.read
        end
    end
end
