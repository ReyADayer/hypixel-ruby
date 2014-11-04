require 'hypixel-ruby'

api = Hypixel::API.new 'your api key here'
player = api.player_by_username 'Cryptsie'
statHolder = player.statHolders[:blitz]

puts    "Coins: #{statHolder.coins}",
        "Wins: #{statHolder.wins}",
        "Kills: #{statHolder.kills}"

guild = api.guild_by_name 'AYS'

puts "Members: #{guild.members.length}"
