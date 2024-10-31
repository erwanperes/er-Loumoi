class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :update, :approve, :reject]

  def index
	  @borrowed_reservations = Reservation.where(borrower_id: current_user.id)
	  @lent_reservations = current_user.items.includes(:reservations).flat_map(&:reservations)
  end

  def show
	  @reservation = Reservation.find(params[:id])
  end

  def new
	@item = Item.find(params[:item_id])
	@reservation = @item.reservations.build
  end

  def create
	  @item = Item.find(params[:item_id])
	  @reservation = @item.reservations.build(reservation_params)
	  @reservation.borrower_id = current_user.id
	  
	  if @reservation.save
		redirect_to @reservation, notice: 'Réservation créée avec succès.'
	  else
		render :new, status: :unprocessable_entity
	  end
	end

  def update
	if @reservation.update(reservation_params)
	  redirect_to @reservation, notice: 'Reservation was successfully updated.'
	else
	  render :show, status: :unprocessable_entity
	end
  end

  def approve
	@reservation.approved!
	redirect_to @reservation, notice: 'Reservation was approved.'
  end

  def reject
	@reservation.rejected!
	redirect_to @reservation, notice: 'Reservation was rejected.'
  end

  private

  def set_reservation
	@reservation = Reservation.find(params[:id])
  end

  def reservation_params
	params.require(:reservation).permit(:start_date, :end_date)
  end
end
