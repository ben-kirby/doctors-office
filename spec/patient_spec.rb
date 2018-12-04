require 'spec_helper'

describe(Patient) do
  describe('.all') do
    it("should return an empty array when nothing is passed in") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("should return a patient object when attributes are passed in") do
      patient = Patient.new({:name => "Jordan Smith", :birthday => '2018-12-04 11:20:44', :doctor_id => 2, :id => nil})
      patient.save()
      patient2 = Patient.new({:name => "Steve Smith", :birthday => '2018-12-04 11:20:44', :doctor_id => 4, :id => nil})
      expect(patient2.save()).to(eq(patient2.id))
    end
  end

  describe('#save') do
    it("should return a patient object when attributes are passed in") do
      patient = Patient.new({:name => "Jordan Smith", :birthday => '2018-12-04 11:20:44', :doctor_id => 2, :id => nil})
      patient.save()
      patient2 = Patient.new({:name => "Steve Smith", :birthday => '2018-12-04 11:20:44', :doctor_id => 4, :id => nil})
      patient2.save()
      expect(Patient.all).to(eq([patient, patient2]))
    end
  end

  describe('.find') do
    it("should find a patient based on id") do
      patient = Patient.new({:name => "Jordan Smith", :birthday => '2018-12-04 11:20:44', :doctor_id => 2, :id => nil})
      patient.save()
      patient2 = Patient.new({:name => "Steve Smith", :birthday => '2018-12-04 11:20:44', :doctor_id => 4, :id => nil})
      patient2.save()
      expect(Patient.find(patient.id)).to(eq(patient))
    end
  end

end
