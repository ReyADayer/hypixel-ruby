module Hypixel

    class Guild

        attr_reader :id, :name, :tag, :motd, :members, :created

        def self.from_json(json)
            members = Array.new
            id = json['_id']
            json = json['guild']

            if json.has_key? 'members'
                json['members'].each do | member |
                    members << GuildMember.from_json(member)
                end
            end

            Guild.new( # This is probably bad syntax.
                id,
                json['name'],
                json['tag'],
                json['motd'],
                members,
                Time.at(json['created'] / 1000)
            )
        end

        def initialize(id, name, tag, motd, members, created)
            @id = id
            @name = name
            @tag = tag
            @motd = motd
            @members = members
            @created = created
        end
    end

    class GuildMember

        attr_reader :username, :rank, :joined

        def self.from_json(json)
            GuildMember.new json['name'], json['rank'], Time.at(json['joined'] / 1000)
        end

        def initialize(username, rank, joined)
            @username = username
            @rank = rank
            @joined = joined
        end
    end
end
