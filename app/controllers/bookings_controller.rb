class BookingsController < ApplicationController
  before_action :set_slot, only: %i[ create update ]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

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

    respond_to do |format|
      if @booking.save
        format.html { redirect_to calendar_url(@slot.calendar), notice: "Booking was successfully created." }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    @booking = Booking.find_by slot_id: @slot.id, user_id: Current.user.id
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to calendar_url(@slot.calendar), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
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
