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

    def select_date(value_string)
      value = Date.parse(value_string)
      @node.click rescue @node.trigger("click")

      page = @node.send(:session)

      # bootstrap-datepicker appends the container to the end of the body tag
      picker = page.within(:xpath, "//body") do # break out of any `within`
        page.all('body > div.datepicker').last
      end

      picker_years = picker.find('.datepicker-years', visible: false)
      picker_months = picker.find('.datepicker-months', visible: false)
      picker_days = picker.find('.datepicker-days', visible: false)

      picker_current_decade = picker_years.find('th.datepicker-switch', visible: false)
      picker_current_year = picker_months.find('th.datepicker-switch', visible: false)
      picker_current_month = picker_days.find('th.datepicker-switch', visible: false)

      if picker_days.visible?
        picker_current_month.click rescue picker_current_month.trigger("click")
      end
      if picker_months.visible?
        picker_current_year.click rescue picker_current_year.trigger("click")
      end

      decade_start, decade_end = picker_current_decade.text.split('-').map(&:to_i)

      if value.year < decade_start.to_i
        gap = decade_start / 10 - value.year / 10
        gap.times do
          th_prev = picker_years.find('th.prev')
          th_prev.click rescue th_prev.trigger("click")
        end
      elsif value.year > decade_end
        gap = value.year / 10 - decade_end / 10
        gap.times do
          th_next = picker_years.find('th.next')
          th_next.click rescue th_next.trigger("click")
        end
      end

      year_el = picker_years.find('.year', text: value.year)
      year_el.click rescue year_el.trigger("click")
      month_el = picker_months.find('.month', text: value.strftime('%b'))
      month_el.click rescue month_eltrigger("click")
      day_xpath = <<-eos
          .//*[contains(concat(' ', @class, ' '), ' day ')
          and not(contains(concat(' ', @class, ' '), ' old '))
          and not(contains(concat(' ', @class, ' '), ' new '))
          and normalize-space(text())='#{value.day}']
      eos
      picker_day = picker_days.find(:xpath, day_xpath)
      picker_day.click rescue picker_day.trigger("click")

      # fail unless page.has_no_css? '.datepicker'
    end

    def date_string
      @node[:value]
    end
  end
end

