class TimerowsController < ApplicationController

  before_filter :authenticate_user!

  layout 'chronos_layout'

  def create
    @timerow = Timerow.new(timerow_params)
    if is_duplicate?
      update_timerow
    else
      create_timerow
    end
  end

  def destroy
    @timerow = Timerow.find(params[:id])
    if @timerow.destroy
      redirect_to edit_timesheet_path(@timerow.timesheet.id), :flash => {:success => "Successfully Removed Row"}
    end
  end


  private

  def is_duplicate?
    !Timerow.where(:timesheet_id => @timerow.timesheet_id, :task_id => @timerow.task_id).empty?
  end

  def create_timerow
    if is_submitted?
      prevent_save
    else
      if @timerow.save
        # success
        redirect_to edit_timesheet_path(@timerow.timesheet.id), :flash => {:success => "Successfully Added Row"}
      else
        # error handling
        redirect_to edit_timesheet_path(@timerow.timesheet.id), :flash => {:error => "Ooops something went wrong!"}
      end
    end
  end

  def update_timerow
    @timerow = Timerow.where(:timesheet_id => @timerow.timesheet_id, :task_id => @timerow.task_id).first
    if is_submitted?
      prevent_save
    else
      if @timerow.update_attributes(timerow_params)
        # success
        redirect_to edit_timesheet_path(@timerow.timesheet.id), :flash => {:success => "Successfully Updated Row"}
      else
        # error handling
        redirect_to edit_timesheet_path(@timerow.timesheet.id), :flash => {:error => "Ooops something went wrong!"}
      end
    end
  end

  def timerow_params
    params.require(:timerow).merge(:total => calculate_total, :task_name => calculate_task_name).permit(:timesheet_id,
                                                                                                        :task_id,
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

  def calculate_total
    %w(monday tuesday wednesday thursday friday saturday sunday).collect { |weekday| params[:timerow][weekday.to_sym].to_f }.inject { |sum, day| sum + day }
  end

  def calculate_task_name
    Task.find(params[:timerow][:task_id]).name
  end

  def prevent_save
    redirect_to edit_timesheet_path(@timerow.timesheet.id), :flash => {:error => "Submitted timesheets cannot be changed"} if @timerow.timesheet.status == 'submitted'
  end

  def is_submitted?
    @timerow.timesheet.status == 'submitted'
  end

end
