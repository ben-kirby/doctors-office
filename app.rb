require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/doctor')
require('./lib/patient')
require('./lib/specialty')
require('pry')

DB = PG.connect({:dbname => 'doctors_office_test'})


get '/' do
  @doctors = Doctor.all
  @specialties = Specialty.all

  erb(:input)
end

post '/' do
  @doctor = Doctor.all
  @specialties = Specialty.all
  erb(:input)
end

get '/add_doctor' do
  @doctors = Doctor.all
  erb(:add_doctor)
end

post '/add_doctor' do
  new_name = params.fetch('new_name')
  new_specialty = params.fetch("new_specialty")
  specialty = Specialty.new({:specialty => new_specialty, :id => nil})
  specialty.save
  specialty_id = Specialty.find_by_name(new_specialty)
  @specialties = Specialty.all
  doctor = Doctor.new({:name => new_name, :specialty => specialty_id.id.to_i, :id => nil})
  doctor.save
  @doctors = Doctor.all
  erb(:add_doctor)
end

get '/add_patient' do
  @doctors = Doctor.all
  @patients = Patient.all
  erb(:add_patient)
end

post '/add_patient' do
  birthday = params.fetch('new_birthday')
  name = params.fetch('new_name')
  doctor = params.fetch('dr-list')
  doctor_id = Doctor.find_by_name(doctor)
  doctor_id = doctor_id.id
  new_patient = Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id, :id => nil})
  new_patient.save()
  @patients = Patient.all
  @doctors = Doctor.all

  erb(:add_patient)
end

get '/specialty_list' do
  @specialty = params.fetch('specialty-list')
  specialty_id = Specialty.find_by_name(@specialty)
  @specialty_id = specialty_id.id.to_i
  @doctors = Doctor.all
  erb(:specialty_list)
end

get '/patient_list' do
  @doctor = params.fetch('dr-list')
  doctor_id = Doctor.find_by_name(@doctor)
  @doctor_id = doctor_id.id.to_i
  @patients = Patient.all
  erb(:patient_list)
end
