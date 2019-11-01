require 'colorize'

@students = [{name: 'John', cohort: 'October', hobby: 'Fishing', height: "5'11''"}, {name: 'Alison', cohort: 'September', hobby: 'Bowling', height: "5'5''"}, {name: 'Raymond', cohort: 'September', hobby: 'Piano', height: "6'1''"}, {name: 'Julie', cohort: 'October', hobby: 'Football', height: "5'10''"}] # an empty array accessible to all methods

def print_menu
  puts "Please select an option".white
  puts "1. Input the students".white
  puts "2. Show the students".white
  puts "3. Save the list to students.csv".white
  puts "4. Load the list from students.csv".white
  puts "5. Add more details to a student".white
  puts "9. Exit".white # 9 because we'll be adding more items
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "5"
    add_info_to_student
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: :November, hobby: 'Unknown', height: 'Unknown'}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "=".center(100, '=').light_cyan
  puts "The students of Villains Academy".center(100).light_cyan
  puts "=".center(100, '=').light_cyan
end

def print_student_list
  @students.each do |student|
    puts "#{@students.index(student) + 1} ||".center(10).light_magenta + "#{student[:name]}".center(15).light_magenta + "#{student[:cohort]} cohort".center(20).light_magenta + "#{student[:hobby]}".center(15).light_magenta + "#{student[:height]}".center(15).light_magenta + "ID: #{student.object_id}".center(15).light_magenta
  end
end

def print_footer
  puts '='.center(100, '=').light_cyan
  puts "Overall, we have #{@students.count} great students".center(100).light_red
end

def add_info_to_student
  #Modify the chosen student
  puts "Please provide the student's ID".light_yellow
  student_id = gets.chomp

  puts "What would you like to add? Please type 'hobby' or 'height'".light_yellow
  addition = gets.chomp

  if addition == 'hobby'
    puts "What is their hobby?".light_yellow
    hobby = gets.chomp

    @students.each do |student|
      if student.object_id == student_id.to_i
        student[:hobby] = hobby
      end
    end

    puts "Thankyou, their information has been added".light_green

  elsif addition == 'height'
    puts "What is their height?".light_yellow
    height = gets.chomp

    @students.each do |student|
      if student.object_id == student_id.to_i
        student[:height] = height
      end
    end

    puts "Their information has been added".light_green

  end


end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit # Quit the program
  end
end

try_load_students
interactive_menu
