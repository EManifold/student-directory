require 'colorize'

@students = []

def print_menu
  puts "Please select an option".white
  puts "1. Load and show the list of students".white
  puts "2. Show the students".white
  puts "3. Input a new student".white
  puts "4. Add more details to a student".white
  puts "5. Show students in a specific cohort".white
  puts "6. Delete a student from the list".white
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
    load_students
    show_students
  when "2"
    show_students
  when "3"
    input_students
  when "4"
    add_info_to_student
  when "5"
    view_by_cohort
  when "6"
    delete_a_student
  when "9"
    save_students
    exit # this will cause the program to terminate
  else
    puts "#{selection} is not a valid option, please try again".light_red
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp

  puts "Please enter their cohort month"
  cohort = STDIN.gets.chomp

  #Dealing with shortened months
  case cohort
  when 'jan'
    cohort = 'January'
  when 'feb'
    cohort = 'February'
  when 'mar'
    cohort = 'March'
  when 'apr'
    cohort = 'April'
  when 'may'
    cohort = 'May'
  when 'june'
    cohort = 'June'
  when 'july'
    cohort = 'July'
  when 'aug'
    cohort = 'August'
  when 'sept'
    cohort = 'September'
  when 'oct'
    cohort = 'October'
  when 'nov'
    cohort = 'November'
  when 'dec'
    cohort = 'December'
  end

  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: cohort, hobby: '', height: ''}

    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
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
  puts "  ".center(10).light_white + "Name".center(15).light_white + "Cohort".center(20).light_white + "Hobby".center(15).light_white + "Height".center(15).light_white + "Student ID".center(15).light_white
  puts '-'.center(100, '-').light_white
end

def print_student_list
  @students.each do |student|
      puts "#{@students.index(student) + 1} ||".center(10).light_magenta + "#{student[:name]}".center(15).light_magenta + "#{student[:cohort]}".center(20).light_magenta + "#{student[:hobby]}".center(15).light_magenta + "#{student[:height]}".center(15).light_magenta + "#{student.object_id}".center(15).light_magenta
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

def view_by_cohort
  puts "Please enter the cohort you would like to view".light_yellow
  chosen_cohort = STDIN.gets.chomp

  print_header
    @students.map do |student|
      if student[:cohort] == chosen_cohort.to_sym
        puts "#{@students.index(student) + 1} ||".center(10).light_magenta + "#{student[:name]}".center(15).light_magenta + "#{student[:cohort]}".center(20).light_magenta + "#{student[:hobby]}".center(15).light_magenta + "#{student[:height]}".center(15).light_magenta + "#{student.object_id}".center(15).light_magenta
      end
    end
  print_footer
end

def delete_a_student
  puts "Please enter the ID of the student you would like to delete".light_yellow
  student_to_delete = STDIN.gets.chomp

  puts "Are you sure you want to delete this student? Please enter 'yes' or 'no'.".light_red
  answer = STDIN.gets.chomp

  if answer == 'yes'
    @students.each do |student|
      if student.object_id == student_to_delete.to_i
        @students.delete(student)
      end
    end
    puts "Student was successfully deleted from the list".light_green
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    if student[:hobby] == ''
      student[:hobby] = 'Unknown'
    end
    if student[:height] == ''
      student[:height] = 'Unknown'
    end
    student_data = [student[:name], student[:cohort], student[:hobby], student[:height]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby, height = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, hobby: hobby, height: height}
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

interactive_menu
