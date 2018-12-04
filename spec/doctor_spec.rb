require 'spec_helper'

describe(Doctor) do
  describe('.all') do
    it("should return an empty array when nothing is passed in") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("should return an empty array when nothing is passed in") do
      new_doctor = Doctor.new({:name => "Dr. Johnson", :specialty => 1, :id => nil})
      new_doctor.save()
      expect(Doctor.all()).to(eq([new_doctor]))
    end
  end

  describe('#find') do
    it("should find a specific record given an id") do
      new_doctor = Doctor.new({:name => "Dr. Johnson", :specialty => 1, :id => nil})
      new_doctor.save()
      new_doctor2 = Doctor.new({:name => "Dr. Smith", :specialty => 2, :id => nil})
      new_doctor2.save()
      expect(Doctor.find(new_doctor2.id)).to(eq(new_doctor2))
    end
  end
end
