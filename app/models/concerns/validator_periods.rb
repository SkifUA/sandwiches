module ValidatorPeriods
  extend ActiveSupport::Concern

  class OrderPeriodDate < ActiveModel::Validator
    def validate(record)
      unless record.start_date < record.finish_date
        record.errors[:finish_date] << I18n.t('periods.msg.invalid.finish_date')
      end
    end
  end

  class MaximumFinishDate < ActiveModel::Validator
    def validate(record)
      return true if Period.count.zero?

      last_max_date = record.id ? Period.period_before(record.id).finish_date : Period.maximum(:finish_date)
      unless  last_max_date < record.start_date
        record.errors[:start_date] << I18n.t('periods.msg.invalid.start_date')
      end
    end
  end

end