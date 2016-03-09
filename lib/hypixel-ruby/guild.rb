module Hypixel

  class Guild

    attr_reader :json, :id, :name, :tag, :motd, :members, :created

    def self.from_json(json)
      Guild.new(json['guild'])
    end

    private

    def initialize(json)
      @json = json
      @id = json['_id']
      @name = json['name']
      @tag = json['tag']
      @motd = json['motd'] ||= []
      @members = []
      @created = Time.at json['created'] / 1000

      if json.has_key? 'members'
        json['members'].each do |member|
          @members << GuildMember.from_json(member)
        end
      end
    end
  end

  class GuildMember

    attr_reader :json, :username, :rank, :joined

    def self.from_json(json)
      GuildMember.new(json)
    end

    private

    def initialize(json)
      @json = json
      @username = json['name']
      @rank = json['rank']
      @joined = Time.at(json['joined'] / 1000)
    end
  end
end
