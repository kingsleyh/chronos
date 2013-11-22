class ApprovalsController < ApplicationController

  before_filter :authenticate_user!, :admin_only

  layout 'chronos_layout'

  def index
   @new= Timesheet.where(:status => 'new')
   @submitted = Timesheet.where(:status => 'submitted')
   @approved = Timesheet.where(:status => 'approved')
   @processed = Timesheet.where(:status => 'processed')
   @rejected = Timesheet.where(:status => 'rejected')
  end

end
