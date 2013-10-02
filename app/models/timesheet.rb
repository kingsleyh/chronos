class Timesheet < ActiveRecord::Base

  has_many :timerows
  accepts_nested_attributes_for :timerows, :reject_if => lambda { |a| a[:timerow].blank? }, :allow_destroy => true

end
