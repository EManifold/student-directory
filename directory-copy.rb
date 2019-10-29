
def input_students
  puts "Please enter the names of the students"
  puts "To finish, hit return four times"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp

  #cohort
  puts "What is their cohort?"
  cohort = gets.chomp

  if cohort == ''
    cohort = 'november'
  end

  #hobbies
  puts "What are their hobbies?"
  hobby = gets.chomp

  #height
  puts "What is their height?"
  height = gets.chomp



  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    if name[0] == 'E' && name.length < 12
      students << {name: name, hobby: hobby, height: height, cohort: cohort.to_sym}
    end

    if students.length != 1
      puts "Now we have #{students.count} students"
    else
      puts "Now we have #{students.count} student"
    end

    #get another name from the students

    name = gets.chomp
    puts "What is their cohort?"
    cohort = gets.chomp
    puts "What are their hobbies?"
    hobby = gets.chomp
    puts "What is their height in feet?"
    height = gets.chomp
  end
  #return the array of students
  students
end

students = input_students
students.sort_by! {|student| student[:cohort].length}

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100, '-')
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]}, (#{student[:cohort]} cohort), their hobby is #{student[:hobby]}, and their height is #{student[:height]} feet tall.".center(100)
  end
end

def print_footer(students)
  if students.count != 1
    puts "Overall we have #{students.count} great students".center(100)
  else
    puts "Overall we have #{students.count} great student".center(100)
  end
end


print_header
print(students)
print_footer(students)
