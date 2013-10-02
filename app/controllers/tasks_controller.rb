class TasksController < ApplicationController
  
  layout 'chronos_layout'

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def show

  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      # success
      redirect_to :tasks
    else
      # error handling
      render new_task_path
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:notice] = "Successfully updated Task."
      redirect_to :tasks
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      redirect_to :tasks
    end
  end


  private

  def task_params
    params.require(:task).permit(:name,
                                  :code,
                                  :description,
                                  :project_id,
                                  :active)
  end
  
end
