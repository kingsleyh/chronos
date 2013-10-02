class TimesheetsController < ApplicationController

  layout 'chronos_layout'

  def index
    @timesheets = Timesheet.all
  end

  def new
    @timesheet = Timesheet.new
  end

  def show

  end

  def edit
    @timesheet = Timesheet.find(params[:id])
    @timerows = @timesheet.timerows
    @timerow = Timerow.new
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    if @timesheet.save
      # success
      redirect_to edit_timesheet_path(@timesheet.id)
    else
      # error handling
      render new_timesheet_path
    end
  end

  def update
    @timesheet = Timesheet.find(params[:id])
    if @timesheet.update_attributes(timesheet_params)
      flash[:notice] = "Successfully updated Timesheet."
      redirect_to :timesheets
    else
      render :action => 'edit'
    end
  end

  def destroy
    @timesheet = Timesheet.find(params[:id])
    if @timesheet.destroy
      redirect_to :timesheets
    end
  end


  private

  def timesheet_params
    params.require(:timesheet).permit(:week_commencing)
  end

end
