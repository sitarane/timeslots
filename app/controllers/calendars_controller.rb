class CalendarsController < ApplicationController
  before_action :set_calendar, only: %i[ show edit update destroy ]

  # GET /calendars or /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1 or /calendars/1.json
  def show
    flash.now[:notice] = I18n.t :please_login unless Current.user
    @editor = @calendar.users.include?(Current.user)
    @assignations = assign_slots if @editor
  end

  # GET /calendars/new
  def new
    authorize Calendar
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
    authorize @calendar
  end

  # POST /calendars or /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.users = [ Current.user ]
    authorize @calendar

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar was successfully created." }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1 or /calendars/1.json
  def update
    authorize @calendar
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar was successfully updated." }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1 or /calendars/1.json
  def destroy
    authorize @calendar
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to calendars_url, notice: "Calendar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def assign_slots
    @score_board = @calendar.score_board
    @guest_count = @calendar.guests.count
    assignations = Hash.new # slot => user
    old_length = 0
    until @score_board.length == old_length
      old_length = @score_board.length

      assignations.merge!(calculated_assignations)
      return assignations if @score_board.empty? || assignations.length == @guest_count

      assignations.merge!(helpers.assign_at_random(@score_board))
      return assignations if @score_board.empty? || assignations.length == @guest_count
    end
    return assignations
  end

  def calculated_assignations
    assignations = Hash.new # slot => user
    old_length = 0
    until @score_board.length == old_length
      old_length = @score_board.length

      assignations.merge!(assign_first_pass)
      return assignations if @score_board.empty? || assignations.length == @guest_count

      assignations.merge!(helpers.assign_most_hated_to_someone_who_wants_it(@score_board))
      return assignations if @score_board.empty? || assignations.length == @guest_count
    end
    return assignations
  end

  def assign_first_pass
    assignations = Hash.new
    old_length = 0
    until @score_board.length == old_length
      old_length = @score_board.length

      assignations.merge!(helpers.assign_wanted_only_by_one(@score_board))
      return assignations if @score_board.empty? || assignations.length == @guest_count

      assignations.merge!(helpers.assign_hated_by_all_minus_one(@score_board))
      return assignations if @score_board.empty? || assignations.length == @guest_count
    end

    assignations.merge!(helpers.assign_most_wanted(@score_board))
    return assignations
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def calendar_params
    params.require(:calendar).permit(:name, :description, :advance_warning, :users)
  end
end
