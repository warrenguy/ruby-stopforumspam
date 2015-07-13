Gem::Specification.new do |s|
  s.name        = 'ruby-stopforumspam'
  s.version     = '0.0.1'
  s.licenses    = ['MIT']
  s.summary     = 'Ruby wrapper for stopforumspam.com API.'
  s.description = 'Ruby wrapper for stopforumspam.com API. Check IP addresses, email addresses, and usernames for known spam activity.'
  s.authors     = ['Warren Guy']
  s.email       = 'warren@guy.net.au'
  s.homepage    = 'https://github.com/warrenguy/ruby-stopforumspam'

  s.files       = Dir['README.md', 'LICENSE', 'lib/*']

  s.add_dependency 'xml-simple'
end
