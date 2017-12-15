class PrescriptionController < ApplicationController
  def index
    @prescriptions = Prescription.all
    @medicines = Medicine.all
  end
  def new
  end
  def show
    @pre= Prescription.find(params[:id])
  end
  def create
    @pre = Prescription.new(pre_params)
    @pre.user = User.first
    if @pre.save
      redirect_to "/medicine/new?id=#{@pre.id}"
    else
      render json: @pre.errors
    end
  end

  def delete
    pre = Prescription.find(params[:id])
    pre.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pre
      @post = Prescription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pre_params
      params.require(:prescription).permit(:title, :hs_name,:ds_name,:ps_date,:cnt,:st_time)
    end
end
