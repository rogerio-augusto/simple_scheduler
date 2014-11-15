module SimpleCalendar
  class WeekCalendar < Calendar
    def date_range
      @date_range ||= begin
                        number_of_weeks = 1 # hardcoding as first challenge scope
                        number_of_days  = 4 # hardcoding as first challenge scope
                        starting_day    = start_date.beginning_of_week.to_date
                        ending_day      = starting_day + number_of_days.days
                        starting_day..ending_day
                      end
    end
  end
end