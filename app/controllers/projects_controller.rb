class ProjectsController < ApplicationController
  
  
  layout 'chronos_layout'

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show

  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      # success
      redirect_to :projects
    else
      # error handling
      render new_project_path
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = "Successfully updated Project."
      redirect_to :projects
    else
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to :projects
    end
  end


  private

  def project_params
    params.require(:project).permit(:name,
                                  :code,
                                  :description,
                                  :customer_id,
                                  :active)
  end

  
end
