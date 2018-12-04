require'pg'
require('pry')


class Patient
  attr_accessor :name, :birthday, :doctor_id, :id

    def initialize(attributes)
      @name = attributes.fetch(:name)
      @birthday = attributes.fetch(:birthday)
      @doctor_id = attributes.fetch(:doctor_id).to_i
      @id = attributes.fetch(:id).to_i
    end

    def self.all
      returned_patients = DB.exec("SELECT * FROM patients;")
      patients = []
      returned_patients.each() do |patient|
        name = patient.fetch("name")
        birthday = patient.fetch("birthday")
        doctor_id = patient.fetch('doctor_id')
        id = patient.fetch("id").to_i()
        patients.push(Patient.new({:name => name, :birthday=>birthday, :doctor_id => doctor_id, :id => id}))
      end
      patients
    end

    def self.find(id)
      returned_patients = DB.exec("SELECT * FROM patients WHERE id = #{id};")
      returned_patients.each() do |patient|
        name = patient.fetch("name")
        birthday = patient.fetch("birthday")
        doctor_id = patient.fetch('doctor_id')
        id = patient.fetch("id").to_i()
        return Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id, :id => id})
      end
    end

    def save
      result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', '#{@doctor_id}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    def ==(another_patient)
      self.name().==(another_patient.name()).&(self.id().==(another_patient.id()))
    end
end
