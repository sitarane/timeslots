class SlotsController < ApplicationController
  before_action :set_slot, only: %i[ show edit update destroy ]
  before_action :set_calendar, only: [:new, :create]

  # GET /slots or /slots.json
  def index
    show_date = params.fetch(:start_date, Date.today).to_date
    @slots = Slot.where(start_time: show_date.beginning_of_month.beginning_of_week..show_date.end_of_month.end_of_week)
  end

  # GET /slots/1 or /slots/1.json
  def show
    @booking = set_booking
    @editor = @slot.calendar.users.include? Current.user
  end

  # GET /slots/new
  def new
    authorize Slot
    @slot = @calendar.slots.new
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

    respond_to do |format|
      if @slot.save
        format.html { redirect_to calendar_slot_url(@slot.calendar, @slot), notice: "Slot was successfully created." }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1 or /slots/1.json
  def update
    authorize @slot
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to calendar_slot_url(@slot), notice: "Slot was successfully updated." }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1 or /slots/1.json
  def destroy
    authorize @slot
    calendar = @slot.calendar
    @slot.destroy

    respond_to do |format|
      format.html { redirect_to calendar_url(calendar), notice: "Slot was successfully destroyed." }
      format.json { head :no_content }
    end
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
      params.require(:slot).permit(:name, :description, :start_time)
    end
end
