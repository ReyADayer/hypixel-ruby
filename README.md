## hypixel-ruby

hypixel-ruby is a basic Ruby client for the Hypixel [PublicAPI](https://github.com/HypixelDev/PublicAPI). It's designed to be used to interface with the API and provides several classes and methods designed to easily allow you to work with the data compared to manually parsing the JSON object the API provides.


### Installing
* Start by cloning the repository: ```git clone https://github.com/Cryptkeeper/hypixel-ruby```
* Now build the Gem: ```gem build hypixel-ruby/hypixel-ruby.gemspec```
* And install it: ```gem install hypixel-ruby/hypixel-ruby-*.gem```

### Usage
* Simply require the newly installed Gem like so: ```require 'hypixel-ruby'```
* Create an instance of using your API key: ```api = Hypixel::API.new 'your key here'```

Note: Consult the [PublicAPI](https://github.com/HypixelDev/PublicAPI) repository for details on obtaining your API key.

### Examples
Simple tasks such as Guild and Friend look ups have mostly-complete APIs due to their simplicity. More complex parts such as Players and their respective Stats are not so well developed as of this time so some nitty-gritty JSON handling may be needed.

Calculating how many people are in a Guild:
```ruby
# First we locate the id of the Guild.
# We can specify an "async" option if we want it to run in a new Thread.
# We can also specify a "join" option if we want to join the new Thread.
api.guild_id_by_name('Kids on your Lawn', {:async => true, :join => true}) do |id|
    # Now that we have the id, let's lookup the actual Guild.
    api.guild_by_id(id) do |guild|
        puts "The Guild \"#{guild.name}\" has #{guild.members.size} member(s)."
    end
end
```

hypixel-ruby also contains a basic caching system that can be enabled like so.
It caches ```maxCount``` of four different types of objects: ```guilds, players, sessions and friends```. It only cache objects that have some sort of a unique identifier (such as the name of a player.)
Any API calls that support caching also allow a "refresh" option which bypasses the cache check.
```ruby
api.cacher.enabled = true # Enable the caching system.
api.cacher.maxCount = 5 # Only allow us to cache 5 objects of each type.
```

Seeing how many Blitz coins a player has:
```ruby
# By specifying "refresh", we force it to make a request and ignore any cache.
api.player_by_username('Cryptsie', {:refresh => true}) do |player|
    coins = player.stats.coins[:Blitz] # Snag their coin count for Blitz.

    puts "#{player.username} has #{coins} Blitz coins"
end
```

Or maybe seeing what Hat a player has in Arena Brawl:
```ruby
# Find the player with the name "Cryptsie", and do it async.
api.player_by_username('Cryptsie', {:async => true}) do |player|
    hat = player.stats.fields[:Arena]['hat'] # Snag the hat field.

    puts "#{player.username} has the \"#{hat}\" hat in Arena Brawl!"
end
```

Seeing who is currently on the leaderboards:
```ruby
api.leaderboards do |leaderboards|
    section = leaderboards.sections[:Blitz][0] # Get the first leaderboard section.
    topPlayer = section.places[0] # Get the first person in the section.

    puts "#{topPlayer} is 1st in #{section.title} for Blitz SG"
end
```


### Notes
* By default all calls are done sync unless the "async" option is provided.
* While there is a caching system, it is very basic. Always cache yourself.
* Due to the lack of extensive features, you may need to hook into the raw JSON responses.
* The codebase may change often and at random as it gets formalized.
* For more information, consult the official [PublicAPI](https://github.com/HypixelDev/PublicAPI) repository.

### Warning

Chances are you should never use this in a production (or in any) environment as it's pretty sketchy (Ruby isn't my primary language so this is a learning experience.) If you do end up using it, don't complain to me if something catches on fire.
