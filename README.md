# ruby-stopforumspam

Ruby wrapper for stopforumspam.com API. Check IP addresses, email addresses,
and usernames for known spam activity.

## Usage

Add the gem to your Gemfile:

```ruby
gem 'ruby-stopforumspam'
```

Then in your project:

```ruby
require 'stopforumspam'

spam_check = StopForumSpam::Check.new(parameters)
spam.check.spammer? # returns Boolean
spam.check.result   # returns Hash
```

Supply a String to check one IP address, e-mail, or username:

```ruby
spam_check = StopForumSpam::Check.new('198.51.100.1')
spam_check.spammer? # is this person a spammer?
=> false
spam_check.result   # see full results from API
=> {"ip"=>{"value"=>"198.51.100.1", "frequency"=>"0", "appears"=>"0"}}
```

Or supply an Array of Strings:

```ruby
spam_check = StopForumSpam::Check.new(['198.51.100.1', 'test@example.com'])
spam_check.spammer?
=> true
spam_check.result
=> {"ip"=>{"value"=>"198.51.100.1", "frequency"=>"0", "appears"=>"0"}, "email"=>{"value"=>"test@example.com", "lastseen"=>"2014-10-06 13:33:08", "frequency"=>"3", "appears"=>"1"}}
```

Or supply an Array of Hashes to override the check type (e.g. to force a
username check for a string that looks like an IP address):

```ruby
spam_check = StopForumSpam::Check.new([{check: '198.51.100.1', type: 'username'}])
spam_check.spammer?
=> true
spam_check.result
=> {"username"=>{"value"=>"198.51.100.1", "frequency"=>"0", "appears"=>"0"}}
```

## License

MIT license. See LICENSE.

## Author

Warren Guy <warren@guy.net.au>

https://warrenguy.me
