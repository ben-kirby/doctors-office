require 'spec_helper'

describe(Specialty) do
  describe('.all') do
    it("should return an empty array when nothing is passed in") do
      expect(Specialty.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("should return a specialty object when attributes are passed in") do
      new_specialty = Specialty.new({:specialty => "Cardiology", :id => nil})
      new_specialty.save()
      new_specialty2 = Specialty.new({:specialty => "Cardiology", :id => nil})
      expect(new_specialty2.save()).to(eq(new_specialty2.id))
    end
  end

  describe('#save') do
    it("should return a specialty object when attributes are passed in") do
      new_specialty = Specialty.new({:specialty => "Cardiology", :id => nil})
      new_specialty.save()
      new_specialty2 = Specialty.new({:specialty => "Pediatrics", :id => nil})
      new_specialty2.save
      expect(Specialty.all).to(eq([new_specialty, new_specialty2]))
    end
  end

  describe('.find_by_name') do
    it("should return a specialty object based on the name") do
      new_specialty = Specialty.new({:specialty => "Cardiology", :id => nil})
      new_specialty.save()
      new_specialty2 = Specialty.new({:specialty => "Pediatrics", :id => nil})
      new_specialty2.save
      expect(Specialty.find_by_name("Cardiology")).to(eq(new_specialty))
    end
  end

end
