class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  #takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
  #adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable.
  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    student_hash = self
    @@all << self
  end

  #uses the Scraper class to create new students with the correct name and location
  def self.create_from_collection(students_array)
    students_array.each do |student|
      student = self.new(student)
    end
  end

  #uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student. 
  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio]
  end

  #returns the class variable @@all
  def self.all
    @@all
  end

end

