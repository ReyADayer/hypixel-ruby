## hypixel-ruby

hypixel-ruby is a basic Ruby client for the Hypixel [PublicAPI](https://github.com/HypixelDev/PublicAPI). It's designed to be used to interface with the API and provides several classes and methods designed to easily allow you to work with the data compared to manually parsing the JSON object the API provides.


### Installing
* Start by cloning the repository: ```git clone https://github.com/Cryptkeeper/hypixel-ruby```
* Now build the Gem: ```gem build hypixel-ruby/hypixel-ruby.gemspec```
* And install it: ```gem install hypixel-ruby/hypixel-ruby-*.gem```

### Usage
* Simply require the newly installed Gem like so: ```require 'hypixel-ruby'```
* Create an instance of using your API key: ```hypixel = Hypixel::API.new 'your key here'```

Note: Consult the [PublicAPI](https://github.com/HypixelDev/PublicAPI) repository for details on obtaining your API key.

### Example
Simple tasks such as Guild and Friend look ups have mostly-complete APIs due to their simplicity. More complex parts such as Players and their respective Stats are not so well developed as of this time so some nitty-gritty JSON handling may be needed.

Also, all API calls accept a block, or you can just be old fashioned and assign it to a variable.

Looping through Guild members:
```ruby
guild = hypixel.guild_by_name 'Kids on your Lawn'
guild.members.each do | member |
        puts "ban #{member.username} Get off my lawn."
end
```

Getting all the friends of a player:
```ruby
friends = hypixel.friends_by_username 'Santa'
friends.each do | friend |
        puts "#{friend.username} has been a friend of Santa since #{friend.since}"
end
````

Seeing how many Blitz coins a player has:
```ruby
player = hypixel.player_by_username 'Cryptsie'
coins = player.stats.coins[:Blitz]

puts "#{player.username} has #{coins} Blitz coins"
````

Or maybe seeing what Hat a player has in Arena Brawl:
```ruby
player = hypixel.player_by_username 'Cryptsie'
hat = player.stats.fields[:Arena]['hat']

puts "#{player.username} has the \"#{hat}\" hat!"
````

hypixel-ruby also contains a basic caching system that can be enabled like so:
```ruby
hypixel.cacher.enabled = true # Enable the caching system.
hypixel.cacher.maxCount = 5 # Only allow us to cache 5 objects (defaults to 10.)
```

Seeing who is currently on the leaderboards:
```ruby
section = api.leaderboards.sections[:Blitz][0]
topPlayer = section.places[0] # Get the first person in the first section.

puts "#{topPlayer} is 1st in #{section.title} for Blitz SG"
```

### Notes
* It's worth noting all calls are done sync so don't do anything too silly.
* Some calls (such as the Guilds) require two lookups due to the parameters required for the request. Always use the recommended methods when possible to avoid using extra resources.
* Due to the lack of extensive features, you may need to hook into the raw JSON responses.
* The codebase may change often and at random as it gets formalized.
* For more information, consult the official [PublicAPI](https://github.com/HypixelDev/PublicAPI) repository.

### Warning

Chances are you should never use this in a production (or in any) environment as it's pretty sketchy (Ruby isn't my primary language so this is a learning experience.) If you do end up using it, don't complain to me if something catches on fire.
