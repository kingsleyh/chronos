class TimesheetsController < ApplicationController

  before_filter :authenticate_user!

  layout 'chronos_layout'

  def index
    @timesheets = Timesheet.where(:user => current_user)
  end

  def new
    @timesheet = Timesheet.new
  end

  def edit
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    @timerows = @timesheet.timerows
    @timerow = Timerow.new

    @week_start = @timesheet.week_commencing

    @days = [
        for_day(@week_start, 0),
        for_day(@week_start, 1),
        for_day(@week_start, 2),
        for_day(@week_start, 3),
        for_day(@week_start, 4),
        for_day(@week_start, 5),
        for_day(@week_start, 6),
    ]
  end

  def create
    @timesheet = Timesheet.new(timesheet_params)
    restrict_timesheet
    if is_duplicate?
      goto_existing_timesheet
    else
      if @timesheet.save
        # success
        redirect_to edit_timesheet_path(@timesheet.id)
      else
        # error handling
        render new_timesheet_path
      end
    end
  end

  def update
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if @timesheet.update_attributes(timesheet_params)
      flash[:notice] = "Successfully updated Timesheet."
      redirect_to :timesheets
    else
      render :action => 'edit'
    end
  end

  def submit
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if !params[:submit].empty? and !@timesheet.locked?
      @timesheet.status = 'submitted'
      @timesheet.save
      flash[:notice] = "Successfully submitted Timesheet."
    end
    redirect_to root_path
  end

  def approve
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if !params[:submit].empty? and @timesheet.locked?
      @timesheet.status = 'approved'
      @timesheet.save
      flash[:notice] = "Successfully approved Timesheet."
    end
    redirect_to root_path
  end

  def unapprove
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if !params[:submit].empty? and @timesheet.locked?
      @timesheet.status = 'submitted'
      @timesheet.save
      flash[:notice] = "Successfully unapproved Timesheet."
    end
    redirect_to root_path
  end

  def process_it
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if !params[:submit].empty? and @timesheet.locked?
      @timesheet.status = 'processed'
      @timesheet.save
      flash[:notice] = "Successfully processed Timesheet."
    end
    redirect_to root_path
  end

  def reject
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if !params[:submit].empty? and @timesheet.locked?
      @timesheet.status = 'rejected'
      @timesheet.save
      flash[:notice] = "Successfully rejected Timesheet."
    end
    redirect_to root_path
  end

  def destroy
    @timesheet = Timesheet.find(params[:id])
    restrict_timesheet
    if !@timesheet.locked? or current_user.admin?
      if @timesheet.destroy
        redirect_to :timesheets
      end
    end
  end


  private

  def timesheet_params
    params.require(:timesheet).merge(:user_id => current_user.id).permit(:week_commencing, :status, :user_id)
  end

  def for_day(start, number)
    start.advance(:days => number)
  end

  def restrict_timesheet
    redirect_to root_path unless @timesheet.is_for_user(current_user) or current_user.admin?
  end

  def goto_existing_timesheet
    redirect_to edit_timesheet_path(Timesheet.where(:week_commencing => @timesheet.week_commencing, :user_id => current_user.id).first.id)
  end

  def is_duplicate?
    Timesheet.where(:user_id => current_user.id).collect { |t| t.week_commencing }.include?(@timesheet.week_commencing)
  end

end
