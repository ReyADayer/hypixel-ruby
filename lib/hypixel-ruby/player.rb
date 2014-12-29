module Hypixel

	class Player

		attr_reader :json, :id, :username, :uuid, :stats, :rank

		def self.from_json(json)
			Player.new(json['player'])
		end

		private

		def initialize(json)
			@json = json
			@id = json['_id']
			@username = json['playername']
			@uuid = json['uuid']
			@stats = Stats.from_json json
			@rank = Rank.top [json['rank'], json['packageRank'], json['newPackageRank']], false
		end
	end
end
