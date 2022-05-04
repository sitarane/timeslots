class BookingsController < ApplicationController
  before_action :set_slot, only: %i[ create update ]

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @booking = @slot.bookings.new(booking_params)
    @booking.user = Current.user

    if @booking.save
      redirect_to calendar_url(@slot.calendar), notice: t(:booking_created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    @booking = Booking.find_by slot_id: @slot.id, user_id: Current.user.id
    if @booking.update(booking_params)
      redirect_to calendar_url(@slot.calendar), notice: t(:booking_updated)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    redirect_to bookings_url, notice: t(:booking_destroyed)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(booking_params[:slot_id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:score, :slot_id)
    end
end
