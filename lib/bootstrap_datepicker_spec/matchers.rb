require "rspec/expectations"

RSpec::Matchers.define :have_selected_date do |expected|
  match do |actual|
    actual_date = actual.date_string
    actual_date == expected
  end

  failure_message do |actual|
    "expected datepicker to have selected date #{expected} but was #{actual.date_string}"
  end
end

