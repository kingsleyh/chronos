class TimerowsController < ApplicationController


  layout 'chronos_layout'

  #def index
  #  @timesheets = Timesheet.all
  #end
  #
  #def new
  #  @timesheet = Timesheet.new
  #end
  #
  #def show
  #
  #end
  #
  #def edit
  #  @timesheet = Timesheet.find(params[:id])
  #  @timerows = @timesheet.timerows
  #  @timerow = Timerow.new
  #end

  def create
    @timerow = Timerow.new(timerow_params)
    if @timerow.save
      # success
      redirect_to edit_timesheet_path(@timerow.timesheet.id)
    else
      # error handling
      render edit_timesheet_path(@timerow.timesheet.id)
    end
  end

  #def update
  #  @timesheet = Timesheet.find(params[:id])
  #  if @timesheet.update_attributes(timesheet_params)
  #    flash[:notice] = "Successfully updated Timesheet."
  #    redirect_to :timesheets
  #  else
  #    render :action => 'edit'
  #  end
  #end

  def destroy
    @timerow = Timerow.find(params[:id])
    if @timerow.destroy
      redirect_to edit_timesheet_path(@timerow.timesheet.id)
    end
  end


  private

  def timerow_params
    params.require(:timerow).permit(:timesheet_id,
                                    :task_name,
                                    :monday,
                                    :tuesday,
                                    :wednesday,
                                    :thursday,
                                    :friday,
                                    :saturday,
                                    :sunday,
                                    :total

    )
  end


end
