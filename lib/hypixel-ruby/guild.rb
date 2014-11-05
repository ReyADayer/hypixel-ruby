module Hypixel

    class Guild

        attr_reader :id, :name, :tag, :motd, :members, :created

        # Constructs a Guild instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Guild.new json['guild']
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @id = json['_id']
            @name = json['name']
            @tag = json['tag']
            @motd = json['motd'] ||= []
            @members = []
            @created = Time.at json['created'] / 1000

            if json.has_key? 'members'
                json['members'].each do | member |
                    @members << GuildMember.new(member)
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

        public

        # Creates a JSON object that follows the same format as needed to create an instance.
        # As such, it also matches the output of the API's requests.
        def to_json
            ({
                :name => @username,
                :rank => @rank,
                :joined => @joined.to_i * 1000
            }).to_json
        end
    end
end
