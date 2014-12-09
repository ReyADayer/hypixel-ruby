require 'logger'
require 'open-uri'
require 'json'

module Hypixel

    class API

        attr_reader :apiKey, :cacher

        def initialize(apiKey)
            @apiKey = apiKey
            @cacher = Cacher.new
        end

        # Returns an Array of Friend instances consisting of the Player's friends list.
        #
        # Params:
        # +username+::Username to find Friends of.
        def friends_by_username(username)
            request = make_request 'friends', {
                :player => username
            }

            friends = []

            if request.has_key? 'records'
                request['records'].each do | record |
                    friends << Friend.from_json(record)
                end
            end

            if block_given?
                yield friends
            end

            friends
        end

        # Returns a Guild object concerning the Guild.
        # Retrieved using the Guild's ID.
        #
        # Calls API method "guild"
        #
        # Params:
        # +id+::The ID of the Guild.
        def guild_by_id(id)
            request = make_request 'guild', {
                :id => id
            }

            guild = Guild.from_json request

            if block_given?
                yield guild
            end

            guild
        end

        # Looks up the Guild's id using the provided name and then returns the result of guild_by_id.
        # Due to it's nature, this runs two queries.
        #
        # Calls API method "findGuild"
        #
        # Params:
        # +name+::The name of the Guild.
        def guild_by_name(name)
            id = make_request 'findGuild', {
                :byName => name
            }

            guild_by_id id['guild']
        end

        # Looks up the guild's id using the provided member and then returns the result of guild_by_id.
        # Due to it's nature, this runs two queries.
        #
        # Calls API method "findGuild"
        #
        # Params:
        # +username+::The username of a member of the Guild.
        def guild_by_member(username)
            id = make_request 'findGuild', {
                :byPlayer => username
            }

            guild_by_id id['guild']
        end

        # Returns a Player object concerning the Player. Retrieved using the username.
        #
        # Calls API method "player"
        #
        # Params:
        # +username+::Using a UUID is preferred to make sure you get the desired player.
        def player_by_username(username)
            request = make_request 'player', {
                :name => username
            }

            player = Player.from_json request

            if block_given?
                yield player
            end

            player
        end

        # Returns a Player object concerning the Player. Retrieved using the UUID.
        #
        # Calls API method "player"
        #
        # Params:
        # +uuid+::The player's UUID. This should NOT contain dashes.
        def player_by_uuid(uuid)
            request = make_request 'player', {
                :uuid => uuid
            }

            player = Player.from_json request

            if block_given?
                yield player
            end

            player
        end

        # Returns a Session concerning the Player. Retrieved using the username.
        #
        # Calls API method "player"
        #
        # Params:
        # +username+::The username of the player.
        def session_by_username(username)
            request = make_request 'session', {
                :player => username
            }

            session = Session.from_json request

            if block_given?
                yield session
            end

            session
        end

        # Returns an Array of active Boosters.
        #
        # Calls API method "boosters"
        def boosters
            request = make_request 'boosters'
            boosters = []

            if request.has_key? 'boosters'
                request['boosters'].each do | json |
                    boosters << Booster.from_json(json)
                end
            end

            if block_given?
                yield boosters
            end

            boosters
        end

        # Returns the online player count.
        # Should be updated every second by the API server.
        #
        # Calls API method "playerCount"
        def player_count
            playerCount = make_request('playerCount')['count']

            if block_given?
                yield playerCount
            end

            playerCount
        end

        # Returns a Key object, which includes information concerning
        # your API key's request history.
        #
        # Calls API method "key"
        def key_info
            request = make_request 'key'

            key = Key.from_json request

            if block_given?
                yield key
            end

            key
        end

        private

        # Automatically generates and executes a request given the type and parameters.
        #
        # If the Cacher is enabled, this will return a cached value if available.
        # Otherwise it will run the request and cached the value.
        #
        # Params:
        # +type+::The API method being called. Tends to be a magic value.
        # +params+::Request parameters, the API key is automagically appended to this array.
        def make_request(type, params = {})
            params[:key] = apiKey

            uri = URI.parse "https://api.hypixel.net/#{type}"
            uri.query = URI.encode_www_form params

            if cacher.has? uri
                return cacher.get uri
            end

            puts "#{uri}"

            json = JSON.parse uri.open.read

            cacher.store uri, json
        end
    end
end
