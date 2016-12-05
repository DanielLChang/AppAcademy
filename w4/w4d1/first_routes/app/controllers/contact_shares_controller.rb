class ContactSharesController < ApplicationController

  def create
    @share = ContactShare.new(contact_share_params)

    if @share.save
      render json: @share
    else
      render json: @share.errors.full_messages, status: :unprotected_entity
    end

  end

  def destroy
    @share = ContactShare.find(params[:id])
    @share.destroy
    render json: @share
  end

  private

  def contact_share_params
    params.require(:contact_share).permit(:contact_id, :user_id)
  end
end
