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
      assignations = Hash.new # slot => user
      old_board = Hash.new
      until @score_board == old_board
        old_board = @score_board
        assignations.merge(assign_first_pass)
        return assignations if @score_board.empty?
        assignations.merge(
          helpers.assign_most_hated_to_someone_who_wants_it(@score_board)
        )
        return assignations if @score_board.empty?
      end
      return false
    end

    def assign_first_pass
      assignations = Hash.new
      old_board = Hash.new
      until @score_board == old_board
        old_board = @score_board
        assignations.merge(assign_wanted_only_by_one)
        return assignations if @score_board.empty?

        assignations.merge(
          helpers.assign_hated_by_all_minus_one(@score_board)
        )
        return assignations if @score_board.empty?

        assignations.merge(
          helpers.assign_most_wanted(@score_board)
        )
        return assignations if @score_board.empty?
      end
      return assignations
    end

    def assign_wanted_only_by_one
      assignations = Hash.new
      old_board = Hash.new
      until @score_board == old_board
        old_board = @score_board
        assignations.merge(helpers.assign_wanted_only_by_one(@score_board))
        return assignations if @score_board.empty?
      end
      return assignations
    end

    def assign_hated_by_all_minus_one
      assignations = Hash.new
      old_board = Hash.new
      until @score_board == old_board
        old_board = @score_board
        assignations.merge(helpers.assign_hated_by_all_minus_one(@score_board))
        return assignations if @score_board.empty?
      end
      return assignations
    end

    def assign_most_wanted
      assignations = Hash.new
      old_board = Hash.new
      until @score_board == old_board
        old_board = @score_board
        assignations.merge(helpers.assign_most_wanted(@score_board))
        return assignations if @score_board.empty?
      end
      return assignations
    end

    def assign_most_hated_to_someone_who_wants_it
      assignations = Hash.new
      old_board = Hash.new
      until @score_board == old_board
        old_board = @score_board
        assignations.merge(helpers.assign_most_hated_to_someone_who_wants_it(@score_board))
        return assignations if @score_board.empty?
      end
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
