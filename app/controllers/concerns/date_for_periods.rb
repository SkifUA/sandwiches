module DateForPeriods
  extend ActiveSupport::Concern
  def default_days
    5
  end

  def date_of_next(last_date, day)
    date  = Date.parse(day)
    delta = date > last_date ? 0 : 7
    date + delta
  end

  def last_finish_date
    Period.maximum(:finish_date)
  end

  def default_period
    period = Period.new
    period.days = default_days
    period.start_date = date_of_next(last_finish_date, 'Monday')
    period.finish_date = period.start_date + default_days.day
    period
  end
end
