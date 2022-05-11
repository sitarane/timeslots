class CalendarsController < ApplicationController
  include Scores
  before_action :set_calendar, only: %i[ show edit update destroy ]

  # GET /calendars or /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1 or /calendars/1.json
  def show
    flash.now[:notice] = I18n.t :please_login unless Current.user
    @editor = @calendar.users.include?(Current.user)
    @assignations = ScoreBoard.new(@calendar.score_board).assign_slots if @editor
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

    if @calendar.save
      redirect_to calendar_url(@calendar), notice: t(:calendar_created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /calendars/1 or /calendars/1.json
  def update
    authorize @calendar
    if calendar_params[:new_editors_email_list]
      if add_editors
        redirect_to calendar_url(@calendar), notice: t(:calendar_updated)
      else
        redirect_to calendar_url(@calendar), alert: t(:calendar_update_failed)
      end
    else
      if @calendar.update(calendar_params)
        redirect_to calendar_url(@calendar), notice: t(:calendar_updated)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  # DELETE /calendars/1 or /calendars/1.json
  def destroy
    authorize @calendar
    @calendar.destroy

    redirect_to calendars_url, notice: t(:calendar_updated)
  end

  private

  def add_editors
    emails = calendar_params[:new_editors_email_list]

    # split at spaces and commas
    list_of_emails = emails.split(/[,\s]+/)

    list_of_users = Array.new
    list_of_emails.each do |email|
      list_of_users << User.find_by(email: email)
      #needs to handle users not being found
    end
    @calendar.users << list_of_users
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_calendar
    @calendar = Calendar.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def calendar_params
    params.require(:calendar).permit(
      :name,
      :description,
      :advance_warning,
      :new_editors_email_list)
  end
end
