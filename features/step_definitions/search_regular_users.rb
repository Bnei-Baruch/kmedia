### UTILITY METHODS ###

### GIVEN ###

Given /^no filters are selected$/ do
end

### WHEN ###

When /^I go to the (.*) page$/ do |page|
  visit path_to(page)
end

And /^searching for a pattern "(.*?)"$/ do |pattern|
  @search = Search.new :query_string => pattern
end

### THEN ###

Then /^"(.*?)" result\(s\) should be found$/ do |count|
  @results = @search.search_full_text page
  if count.to_i > 0
    @results.should_not be_false and @results.total.should == count.to_i
  else
    @results.should be_false
  end
end


