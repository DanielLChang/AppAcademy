class CatRentalRequestsController < ApplicationController

  def index
    @rental_requests = CatRentalRequest.all
    render :index
  end

  def new
    @rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @rental_request = CatRentalRequest.new(rental_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      render :new
    end
  end

  def approve
    @rental_request = CatRentalRequest.find_by(id: params[:id])
    @rental_request.approve!
    redirect_to cat_url(@rental_request.cat)
  end

  def deny
    @rental_request = CatRentalRequest.find_by(id: params[:id])
    @rental_request.deny!
    redirect_to cat_url(@rental_request.cat)
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

end
