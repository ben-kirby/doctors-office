require'pg'
require('pry')


class Specialty
  attr_accessor :specialty, :id

  def initialize(attributes)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id).to_i
  end

  def self.all
    returned_specialty = DB.exec("SELECT * FROM specialty;")
    specialties = []
    returned_specialty.each() do |each|
      specialty = each.fetch("specialty")
      id = each.fetch("id").to_i()
      specialties.push(Specialty.new({:specialty => specialty, :id => id}))
    end
    specialties
  end

  def self.find(id)
    returned_specialty = DB.exec("SELECT * FROM specialty WHERE id = #{id};")
    returned_specialty.each() do |specialty|
      name = specialty.fetch("specialty")
      return Specialty.new({:specialty => specialty, :id => id})
    end
  end

  def self.find_by_name(name)
    returned_specialty = DB.exec("SELECT * FROM specialty WHERE specialty = '#{name}';")
    returned_specialty.each() do |specialty|
      specialty2 = specialty.fetch("specialty")
      id = specialty.fetch('id')
      return Specialty.new({:specialty => specialty2, :id => id})
    end
  end

  def save
    specialties = Specialty.all
    if specialties.any? {|specialty| specialty.specialty == self.specialty}
      return self.id
    else
      result = DB.exec("INSERT INTO specialty (specialty) VALUES ('#{@specialty}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end
  end

  def ==(another_specialty)
    self.specialty().==(another_specialty.specialty()).&(self.id().==(another_specialty.id()))
  end
end
