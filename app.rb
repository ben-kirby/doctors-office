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
