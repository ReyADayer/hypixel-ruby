module Hypixel

    class Guild

        attr_reader :id, :name, :tag, :motd, :members, :created

        # Constructs a Guild instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Guild.new json['_id'], json['guild']
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +id+::The Guild's ID.
        # +json+::The JSON object to construct from.
        def initialize(id, json)
            @id = id
            @name = json['name']
            @tag = json['tag']
            @motd = json['motd'] ||= []
            @members = []
            @created = Time.at json['created'] / 1000

            if json.has_key? 'members'
                json['members'].each do | member |
                    @members << GuildMember.new(json)
                end
            end
        end
    end

    class GuildMember

        attr_reader :username, :rank, :joined

        # Constructs a GuildMember instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            GuildMember.new json
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @username = json['name']
            @rank = json['rank']
            @joined = Time.at json['joined'] / 1000
        end
    end
end
