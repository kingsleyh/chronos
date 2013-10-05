class CustomersController < ApplicationController

  before_filter :authenticate_user!, :admin_only

  layout 'chronos_layout'

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def show

  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      # success
      redirect_to :customers
    else
      # error handling
      render new_customer_path
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:notice] = "Successfully updated customer."
      redirect_to :customers
    else
      render :action => 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      redirect_to :customers
    end
  end


  private

  def customer_params
    params.require(:customer).permit(:name,
                                  :code,
                                  :description,
                                  :active)
  end


end
