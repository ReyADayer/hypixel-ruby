module Hypixel

	class Session

		attr_reader :json, :game_type, :id, :players, :server

		def self.from_json(json)
			Session.new(json['session'])
		end

		private

		def initialize(json)
			@json = json
			@game_type = GameType.from_string json['gameType']
			@id = json['_id']
			@players = json['players'] ||= []
			@server = json['server']
		end
	end
end
