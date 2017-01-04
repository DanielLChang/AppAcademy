class Api::PartiesController < ApplicationController
  def index
    @parties = Party.all
    render :index, includes(guests: [:gifts])
  end

  def show
    @party = Party.includes(guests: [:gifts]).find(params[:id])
    render :show
  end
end
