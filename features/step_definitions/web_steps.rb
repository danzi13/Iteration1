# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
# When /^(.*) within (.*[^:])$/ do |step, parent|
#   with_scope(parent) { When step }
# end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When(/^I press "([^"]*)"$/) do |button|
  # click_button(button)
  click_on(button)
end

When(/^I click "Save"$/) do
  click_button("Save")
end

When("I click a submit tag") do
  click_button("Save") 
end


When /^I press "([^"]*)" within "(.*)"/ do |button, form_id|
  within('div.row1') do
    within('div.col-md-62') do
      within "form##{form_id}" do
        click_button(button)
      end
    end
  end
end

When(/^I press the "(.*?)" button$/) do |name|
  click_button(name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

When("I attach an invalid file") do
  attach_file('resume[attachment]', '/home/codio/workspace/Iteration/bad_file.JPG')
end

When /^I attach the file "([^"]*)"$/ do |path|
  
end

When("I submit the form") do
  find('form.form').find('input[type="submit"]').click # Adjust the selector based on your form's structure
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text, wait: 3)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see the error "([^"]*)"$/ do |text|
  if page.respond_to? :should
    puts page.html
    page.should have_content(text, wait: 3)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  if classes.respond_to? :should
    classes.should include(error_class)
  else
    assert classes.include?(error_class)
  end

  if page.respond_to?(:should)
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  else
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      assert error_paragraph.has_content?(error_message)
    else
      assert page.has_content?("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  if classes.respond_to? :should
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  else
    assert !classes.include?('field_with_errors')
    assert !classes.include?('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end
 
Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')} 
  
  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

Then("the resume textarea should contain {string}") do |expected_text|
  textarea = find('.my-own-class')  # Assuming you can locate the textarea by its id

  # Get the content of the textarea and assert that it contains the expected text.
  expect(textarea.text).to include(expected_text)
end




Given("a resume with a non-empty tailored resume") do
  @last_resume = Resume.new
  @tailored_resume = "This is a non-empty tailored resume."
end

Given("a resume with an empty tailored resume") do
  @last_resume = Resume.new
  @tailored_resume = ""
end

Given("a resume with a tailored resume containing newline characters") do
  @last_resume = Resume.new
  @tailored_resume = "Line 1\nLine 2\nLine 3"
end

When("I save the resume") do
  @last_resume.title = @tailored_resume.gsub('\n', "\n")
  @last_resume.resume_text = @tailored_resume.gsub('\n', "\n")
  @last_resume.save
end

Then("the resume should be saved successfully") do
  expect(@last_resume.valid?).to be true
end

Then("the resume shouldn't be saved successfully") do
  expect(@last_resume.valid?).to be false
end






Given("a resume section with the word 'skills'") do
  @prompt = "Original Resume Section: This is a skills section."
end

Given("a resume section with the word 'work'") do
  @prompt = "Original Resume Section: This is a work section."
end

Given("a resume section with the word 'experience'") do
  @prompt = "Original Resume Section: This is an experience section."
end

Given("a resume section without 'skills', 'work', or 'experience'") do
  @prompt = "Original Resume Section: This is a section without keywords."
end

When("I tailor the resume section") do
  @sections = Gpt3Service.call(@prompt, 'gpt-3.5-turbo-0301').split('&&&')
  @tailored_resume = ''

  for s in @sections
    @s = s
    if @s.include?('skills') || @s.include?('work') || @s.include?('experience')
      @prompt = "Job Description: Some job description\n\nResume section to be tailored: #{@s} \n\nNew Tailored Section: "
      @tailored_section = Gpt3Service.call(@prompt, 'gpt-3.5-turbo-0301')
      @tailored_resume += @tailored_section + '\n'
    else
      @tailored_resume += @s + '\n'
    end
  end
end

Then("the tailored resume should contain {string}") do |expected_text|
  expect(@tailored_resume).to include(expected_text)
end