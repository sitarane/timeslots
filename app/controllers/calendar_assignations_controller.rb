class CalendarAssignationsController < ApplicationController
  before_action :set_calendar_assignation, only: %i[ edit update destroy ]
  before_action :set_calendar, except: :edit

  # POST /calendar_assignations or /calendar_assignations.json
  def create
    @calendar_assignation = @calendar.calendar_assignations.new(calendar_assignation_params)

    respond_to do |format|
      if @calendar_assignation.save
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar assignation was successfully created." }
        format.json { render :show, status: :created, location: @calendar_assignation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar_assignation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendar_assignations/1 or /calendar_assignations/1.json
  def update
    respond_to do |format|
      if @calendar_assignation.update(calendar_assignation_params)
        format.html { redirect_to calendar_url(@calendar), notice: "Calendar assignation was successfully updated." }
        format.json { render :show, status: :ok, location: @calendar_assignation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calendar_assignation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_assignations/1 or /calendar_assignations/1.json
  def destroy
    @calendar_assignation.destroy

    respond_to do |format|
      format.html { redirect_to calendar_url(@calendar), notice: "Calendar assignation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_assignation
      @calendar_assignation = CalendarAssignation.find(params[:id])
    end

    def set_calendar
      @calendar = Calendar.find(params[:calendar_id])
    end

    # Only allow a list of trusted parameters through.
    def calendar_assignation_params
      params.require(:calendar_assignation).permit(:user_id, :calendar_id)
    end
end
