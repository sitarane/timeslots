class SlotsController < ApplicationController
  before_action :set_slot, only: %i[ show edit update destroy ]
  before_action :set_calendar, only: [:new, :create]

  # GET /slots/1 or /slots/1.json
  def show
    authorize @slot
    @booking = set_booking
    @editor = @slot.calendar.editors.include? Current.user
  end

  # GET /slots/new
  def new
    authorize Slot
    in_two_days_at_8 = (Time.zone.now + 2.days).beginning_of_day + 8.hours
    @slot = @calendar.slots.new(start_time: in_two_days_at_8)
  end

  # GET /slots/1/edit
  def edit
    authorize Slot
  end

  # POST /slots or /slots.json
  def create
    @slot = Slot.new(slot_params)
    @slot.calendar = @calendar
    authorize @slot

    if @slot.save
      redirect_to calendar_url(@slot.calendar), notice: t(:slot_created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slots/1 or /slots/1.json
  def update

    authorize @slot
      if @slot.update(slot_params)
        redirect_to calendar_url(@slot.calendar), notice: t(:slot_updated)
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /slots/1 or /slots/1.json
  def destroy
    authorize @slot
    calendar = @slot.calendar
    @slot.destroy

    redirect_to calendar_url(calendar), notice: t(:slot_destroyed)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    def set_calendar
      @calendar = Calendar.find(params[:calendar_id])
    end

    def set_booking
      existing = Booking.find_by slot_id: @slot.id, user_id: Current.user.id
      return existing if existing
      return @slot.bookings.new(user: Current.user)
    end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:description, :start_time)
    end
end
