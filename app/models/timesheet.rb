class Timesheet < ActiveRecord::Base

  has_many :timerows
  belongs_to :user

  FORMAT = "%d %b %Y"

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

  def locked?
    %w(submitted approved).include?(status)
  end

  def submitted?
    status == 'submitted'
  end

  def week_commencing_pretty
    week_commencing.strftime(FORMAT)
  end

  def total_hours
    timerows.collect { |r| r.total }.inject { |sum, row| sum + row }
  end

  def is_for_user(supplied_user)
    if !user
      return false
    elsif user.id == supplied_user.id
      return true
    end
    false
  end

  private

  def self.week_past(number_of, time)
    week = time.ago(number_of.weeks)
    start = week.beginning_of_week.strftime(FORMAT)
    finish = week.end_of_week.strftime(FORMAT)
    ["#{start} - #{finish}", week.beginning_of_week]
  end

  def self.week_future(number_of, time)
    week = time.in(number_of.weeks)
    start = week.beginning_of_week.strftime(FORMAT)
    finish = week.end_of_week.strftime(FORMAT)
    ["#{start} - #{finish}", week.beginning_of_week]
  end

end
