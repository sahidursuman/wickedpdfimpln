class PatientsController < ApplicationController
   def create
    @doctor = Doctor.find(params[:doctor_id])
    @patient = @doctor.patients.create(params[:patient].permit(:name, :age, :gender))
    @patient.delete_flg = FALSE
    redirect_to doctor_path(@doctor)
  end
  
  def generate_pdf
	@patients = Patient.all
    pdf = WickedPdf.new.pdf_from_string(render_to_string('patients/pdf.html.erb'))
    save_path = Rails.root.join('pdfs','All_Patients')
	File.open(save_path, 'wb') do |file|
		file << pdf
	end
	pdf_filename = File.join(Rails.root, "pdfs/All_Patients")
	send_file(pdf_filename, :filename => "All_patients.pdf", :disposition => 'inline', :type => "application/pdf")

  end
end
