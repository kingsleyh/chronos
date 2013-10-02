class Timesheet < ActiveRecord::Base

  has_many :timerows
  accepts_nested_attributes_for :timerows, :reject_if => lambda { |a| a[:timerow].blank? }, :allow_destroy => true

  def self.weeks
    time = Time.now
    [
       week_past(10, time),
       week_past(9, time),
       week_past(8, time),
       week_past(7, time),
       week_past(6, time),
       week_past(5, time),
       week_past(4, time),
       week_past(3, time),
       week_past(2, time),
       week_past(1, time),
       week_past(0, time),
       week_future(1, time),
       week_future(2, time),
       week_future(3, time),
       week_future(4, time),
       week_future(5, time),
       week_future(6, time),
       week_future(7, time),
       week_future(8, time),
       week_future(9, time),
       week_future(10, time),
    ]
  end

  private

  def self.week_past(number_of, time)
    week = time.ago(number_of.weeks)
    format = "%d %b %Y"
    start = week.beginning_of_week.strftime(format)
    finish = week.end_of_week.strftime(format)
    ["#{start} - #{finish}", week.beginning_of_week]
  end

  def self.week_future(number_of, time)
    week = time.in(number_of.weeks)
    format = "%d %b %Y"
    start = week.beginning_of_week.strftime(format)
    finish = week.end_of_week.strftime(format)
    ["#{start} - #{finish}", week.beginning_of_week]
  end

end
