# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regex = /#{e1}.*#{e2}/m
  page.body.should match(regex)
#  assert page.body.match(regex)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split.each do |r|
    action_str = "I " + uncheck.to_s + "check \"ratings_#{r}\""
    step action_str
  end
end

Then /^I should( not)? see the following:$/ do |neg, movies_table|
  movies_table.hashes.each do |movie|
    title = movie[:title]
    action_str = "I should" + neg.to_s + " see \"#{title}\""
    step action_str
  end
end

Then /^the movie list should have (\d+) movie[s]*$/ do |n|
#  all('#movielist tr').size.should == n.to_i
  assert all('#movielist tr').size == n.to_i
end
