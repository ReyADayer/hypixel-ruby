module Hypixel

  class API

    attr_reader :api_key, :requester, :cacher

    def initialize(api_key)
      @api_key = api_key
      @requester = Requester.new(self)
      @cacher = Cacher.new
    end

    # Options: async refresh
    #
    # Constructs a list of all "friends" of the player (found using +username+).
    # This includes sent and received requests that were accepted by both parties.
    #
    # Params:
    # +username+::The username of the player.
    def friends_by_username(username, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:friend, username)
        yield @cacher.get(:friend, username)

        return
      end

      @requester.make_request({
                                  :method => 'friends',
                                  :params => {
                                      :player => username
                                  },
                                  :options => options
                              }) do |friends|
        listing = []

        if friends.has_key? 'records'
          friends['records'].each do |friend|
            listing << Friend.from_json(friend)
          end
        end

        yield @cacher.put(:friend, username, listing)
      end
    end

    # Options: async refresh
    #
    # Constructs a Guild object based off the id.
    #
    # Params:
    # +username+::The id of the Guild.
    def guild_by_id(id, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:guild, id)
        yield @cacher.get(:guild, id)

        return
      end

      @requester.make_request({
                                  :method => 'guild',
                                  :params => {
                                      :id => id
                                  },
                                  :options => options
                              }) do |guild|
        yield @cacher.put(:guild, id, Guild.from_json(guild))
      end
    end

    # Options: async refresh
    #
    # Runs a query to determine the id of the Guild,
    # it then uses this to lookup and construct the Guild object.
    #
    # If you know the Guild's id, it's recommended to use guild_by_id.
    #
    # Params:
    # +name+::The name of the Guild.
    def guild_id_by_name(name, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:guild, name)
        yield @cacher.get(:guild, name)

        return
      end

      @requester.make_request({
                                  :method => 'findGuild',
                                  :params => {
                                      :byName => name
                                  },
                                  :options => options
                              }) do |guild|
        yield @cacher.put(:guild, name, guild['guild'])
      end
    end

    # Options: async refresh
    #
    # Runs a query to determine the Guild of the player,
    # it then uses this to lookup and construct the Guild object.
    #
    # If you know the Guild's id, it's recommended to use guild_by_id.
    #
    # Params:
    # +username+::A username of a player in the Guild.
    def guild_id_by_member(username, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:guild, username)
        yield @cacher.get(:guild, username)

        return
      end

      @requester.make_request({
                                  :method => 'findGuild',
                                  :params => {
                                      :byPlayer => username
                                  },
                                  :options => options
                              }) do |guild|
        yield @cacher.put(:guild, username, guild['guild'])
      end
    end

    # Options: async refresh
    #
    # Constructs a Player object around the username provided.
    #
    # Params:
    # +username+::The username of the player.
    def player_by_username(username, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:player, username)
        yield @cacher.get(:player, username)

        return
      end

      @requester.make_request({
                                  :method => 'player',
                                  :params => {
                                      :name => username
                                  },
                                  :options => options
                              }) do |player|
        yield @cacher.put(:player, username, Player.from_json(player))
      end
    end

    # Options: async refresh
    #
    # Constructs a Player object around the uuid provided.
    #
    # Params:
    # +uuid+::The uuid of the player.
    def player_by_uuid(uuid, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:player, uuid)
        yield @cacher.get(:player, uuid)

        return
      end

      @requester.make_request({
                                  :method => 'player',
                                  :params => {
                                      :uuid => uuid
                                  },
                                  :options => options
                              }) do |player|
        yield @cacher.put(:player, uuid, Player.from_json(player))
      end
    end

    # Options: async refresh
    #
    # Constructs a Session object based off the player with the specified username.
    # If the player is not in a game session, it will return nil.
    #
    # Params:
    # +username+::The username of the player.
    def session_by_username(username, options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      if (!options[:refresh]) && @cacher.has?(:session, username)
        yield @cacher.get(:session, username)

        return
      end

      @requester.make_request({
                                  :method => 'session',
                                  :params => {
                                      :player => username
                                  },
                                  :options => options
                              }) do |session|
        yield @cacher.put(:session, username, Session.from_json(session))
      end
    end

    # Options: async
    #
    # Returns a list of Booster objects.
    # Includes queued and active boosters.
    def boosters(options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      @requester.make_request({
                                  :method => 'boosters',
                                  :options => options
                              }) do |boosters|
        listing = []

        if boosters.has_key? 'boosters'
          request['boosters'].each do |booster|
            listing << Booster.from_json(booster)
          end
        end

        yield listing
      end
    end

    # Options: async anonymous
    #
    # Returns an integer of the number of players currently on the network.
    # It should be recent (1-3 seconds) however sometimes can be outdated.
    #
    # The call itself does not require a API key. As such if you wish to not
    # send your key in the request, specify :anonymous in the options.
    def player_count(options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      @requester.make_request({
                                  :method => 'playerCount',
                                  :options => options
                              }) do |player_count|
        yield player_count['count'].to_i
      end
    end

    # Options: async
    #
    # Returns a Key object that includes information about your API key.
    def key_info(options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      @requester.make_request({
                                  :method => 'key',
                                  :options => options
                              }) do |key|
        yield Key.from_json(key)
      end
    end

    # Options: async
    #
    # Returns a Leaderboards object that includes leaderboard
    # information for all games, network wide.
    def leaderboards(options = {})
      unless block_given?
        raise ArgumentError, 'No block given!'
      end

      @requester.make_request({
                                  :method => 'leaderboards',
                                  :options => options
                              }) do |leaderboards|
        yield Leaderboards.from_json(leaderboards)
      end
    end
  end
end
