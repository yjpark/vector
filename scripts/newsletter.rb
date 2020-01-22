#!/usr/bin/env ruby

# newsletter.rb
#
# SUMMARY
#
#   Creates a newsletter body of releases and blogs since now and N days (30 by
#   default).

require_relative "setup"

metadata = Metadata.load!(META_ROOT, DOCS_ROOT, PAGES_ROOT)

cover_days = 30
if ARGV.length > 0
  cover_days = ARGV[0].to_i
end

newsletter_from = Date.today - cover_days

last_release = metadata.releases_list[-1]
if last_release.date > newsletter_from
  print "** New Release\n"
  print "------------------------------------------------------------\n\n"
  print "First up, there's a new version of Vector (v#{last_release.version}) to check out. (https://vector.dev/releases/#{last_release.version})\n"
  print "\n"
end

print "** Posts\n"
print "------------------------------------------------------------\n\n"
print "And here's a collection of posts we've published since the last newsletter:\n\n"
metadata.posts.each do |post|
  if post.date > newsletter_from
    print "- (#{post.date}) #{post.title} (#{post.permalink})\n"
  end
end