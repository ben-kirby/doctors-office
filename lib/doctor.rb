require('pg')
require('pry')

# DB = PG.connect({:dbname => 'doctors_office_test'})


class Doctor
  attr_accessor :name, :specialty, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id).to_i
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch("id").to_i
      doctors.push(Doctor.new({:name => name, :specialty=>specialty, :id => id}))
    end
    doctors
  end

  def self.find(id)
    returned_doctors = DB.exec("SELECT * FROM doctors WHERE id = #{id};")
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty_id")
      id = doctor.fetch("id").to_i()
      return Doctor.new({:name => name, :specialty => specialty, :id => id})
    end
  end

  def self.find_by_name(doctor_name)
    returned_doctors = DB.exec("SELECT * FROM doctors WHERE name = '#{doctor_name}';")
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty_id")
      id = doctor.fetch("id").to_i()
      return Doctor.new({:name => name, :specialty => specialty, :id => id})
    end
  end

  # def self.find_by_name(name)
  #   returned_name = DB.exec("SELECT * FROM doctors WHERE name = '#{name}';")
  #   returned_name.each() do |name|
  #     name2 = name.fetch("name")
  #     id = name.fetch('id')
  #     return Specialty.new({:specialty => specialty2, :id => id})
  #   end
  # end

  def save
    # specialty_id = Specialty.new(@specialty)
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_doctor)
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id()))
  end
end
