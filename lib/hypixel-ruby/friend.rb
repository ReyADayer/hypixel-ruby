module Hypixel

	class Friend

		attr_reader :json, :id, :sender, :receiver, :since, :sender_uuid, :receiver_uuid

		def self.from_json(json)
			Friend.new(json)
		end

		private

		def initialize(json)
			@json = json
			@id = json['_id']
			@sender = json['sender']
			@receiver = json['receiver']
			@since = Time.at(json['started'] / 1000)
			@sender_uuid = json['uuidSender']
			@receiver_uuid = json['uuidReceiver']
		end
	end
end
