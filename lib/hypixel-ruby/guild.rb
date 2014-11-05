module Hypixel

    class Guild

        attr_reader :id, :name, :tag, :motd, :members, :created

        def self.from_json(json)
            Guild.new json['_id'], json['guild']
        end

        private

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

        def self.from_json(json)
            GuildMember.new json
        end

        private

        def initialize(json)
            @username = json['name']
            @rank = json['rank']
            @joined = Time.at json['joined'] / 1000
        end
    end
end
