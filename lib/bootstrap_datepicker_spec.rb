require "chronic"

require "bootstrap_datepicker_spec/version"
require "bootstrap_datepicker_spec/matchers"

module BootstrapDatepickerSpec
  class DatePicker < SimpleDelegator
    def initialize(node)
      @node = super(node)
      expected_class = Capybara::Node::Element

      unless @node.is_a? expected_class
        raise "Expecting node of type: #{expected_class}, but received node of type #{@node.class} "
      end
    end

    def select_date(date_string)
      time = Chronic.parse(date_string)
      @node.set "#{time.to_date.to_s}\e"
      @node.first(:xpath, './../..').trigger("click")
    end

    def date_string
      @node[:value]
    end
  end
end

