class DoctorsController < ApplicationController
  def index
	@doctors = Doctor.all
	@doctor = Doctor.new
	@patients = Patient.all
  end
  
  def create
	@doctor = Doctor.new(params[:doctor].permit(:name))
	@doctor.delete_flg = FALSE
	@doctor.save
	redirect_to '/'
  end
  
  def show
    @doctor = Doctor.find(params[:id])
  end
  
  def generate_pdf
	@doctor = Doctor.find(params[:id])
    pdf = WickedPdf.new.pdf_from_string(render_to_string('doctors/pdf.html.erb'))
    save_path = Rails.root.join('pdfs',@doctor.name)
	File.open(save_path, 'wb') do |file|
		file << pdf
	end
	pdf_filename = File.join(Rails.root, "pdfs/"+@doctor.name.to_s)
	send_file(pdf_filename, :filename => @doctor.name.to_s+".pdf", :disposition => 'inline', :type => "application/pdf")
  end
end
