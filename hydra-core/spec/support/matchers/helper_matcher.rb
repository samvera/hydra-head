# frozen_string_literal: true

RSpec::Matchers.define :be_html_safe do
  match(&:html_safe?)
  failure_message_for_should do |actual|
    "Expected that #{actual.inspect} would be marked as html safe"
  end

  failure_message_for_should_not do |actual|
    "Expected that #{actual.inspect} would not be marked as html safe"
  end
end
