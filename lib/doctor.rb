class Doctor
  attr_reader :name, :specialty, :id

  def initialize(attributes)
      @id = attributes.fetch(:id)
      @name = attributes.fetch(:name)
      @specialty = attributes.fetch(:specialty)
  end

  def ==(other_doctor)
    same_name = @name == other_doctor.name
    same_specialty = @specialty == other_doctor.specialty
    same_name && same_specialty
  end

  def self.all
    doctors = []
    results = DB.exec("SELECT * FROM doctors;")
    results.each do |doctor|
      id = doctor.fetch('id').to_i
      name = doctor.fetch('name')
      specialty = doctor.fetch('specialty')
      doctors.push(Doctor.new({:id => id, :name => name, :specialty => specialty}))
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first.fetch('id').to_i
  end
end