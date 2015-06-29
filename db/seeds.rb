# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

API_URL = 'http://sandbox.api.hmhco.com/v1'

@teacher_headers = {
  "Content-Type"=> "application/json",
  "Accept" => "text/json",
  "Vnd-HMH-Api-Key"=> ENV["VND_HMH_API_KEY"],
  "Authorization"=> ENV["TEACHER_SIF_TOKEN"]
}

@student_headers = {
  "Content-Type"=> "application/json",
  "Accept" => "text/json",
  "Vnd-HMH-Api-Key"=> ENV["VND_HMH_API_KEY"],
  "Authorization"=> ENV["STUDENT_SIF_TOKEN"]
}

def call_api(endpoint, header)
  response = HTTParty.get(API_URL + endpoint, headers: header)
  # TODO more error checking (500 error, etc)
  json = JSON.parse(response.body)
end

def seed_staff
  json = call_api('/staffPersons', @teacher_headers)
  json.each do |element|
    staff = StaffPerson.create(
      user_name: element["userName"],
      ref_id: element["refId"],
      id_value: "",
      given_name: element["name"]["actualNameOfRecord"]["givenName"],
      family_name: element["name"]["actualNameOfRecord"]["familyName"],
      phone_number: element["phoneNumberList"].first["number"],
      email_address: element["emailList"].first["emailAddress"]
    )
    puts "saved" if staff.save
  end
end

def seed_sections

  json = call_api('/sections', @teacher_headers)
  json.each do |element|
    params = Hash.new
    params["status"] = element["status"]
    params["school_year"] = element["schoolYear"]
    params["ref_id"] = element["refId"]
    periods = ["1st", "2nd", "3rd", "4th", "5th", "6th"]
    classes = ["Geometry", "Algebra", "Calculus"]
    params["name"] = periods.sample + " period " + classes.sample
    section = Section.create(params)
    puts "Hallejah!!" if section.save
  end
end

def seed_staff_sections
  json = call_api('/staffSectionAssociations', @teacher_headers)
  json.each do |element|
    section_association = StaffSectionAssociation.find_or_initialize_by(
      ref_id: element['refId']
    )

    # not all staff/section associations from the API have a staff ID.
    if element["sectionRefId"].nil?
      section_id = rand(1..Section.count)
    else
      section_id = Section.find_by(ref_id: element["sectionRefId"]).id
    end

    if element["staffPersonRefId"].nil?
      staff_person_id = rand(1..StaffPerson.count)
    else
      staff_person_id = StaffPerson.find_by(ref_id: element["staffPersonRefId"]).id
    end

    section_association.section_id = section_id
    section_association.staff_person_id = staff_person_id
    section_association.start_date = element["startDate"]
    section_association.end_date = element["endDate"]
    if section_association.save
      puts 'saved'
    end
  end
end

def seed_students
  json = call_api('/students', @teacher_headers)
  json.each do |element|
    student = Student.find_or_initialize_by(ref_id: element['refId'],
                                            id_value: "",
                                            given_name: element['name']['actualNameOfRecord']['givenName'],
                                            family_name: element['name']['actualNameOfRecord']['familyName'])
    phone_number = element['phoneNumberList']
    student.phone_number = phone_number[0]['number'] unless phone_number.nil?
    email_address = element['emailList']
    student.email_address = email_address[0]['emailAddress'] unless email_address.nil?
    puts 'Student!' if student.save
  end
end

def seed_student_sections
  json = call_api('/studentSectionAssociations', @teacher_headers)
  json.each do |element|
    student_id = Student.find_by(ref_id: element['studentRefId']).id
    section_id = Section.find_by(ref_id: element['sectionRefId']).id
    student_section = StudentSectionAssociation.find_or_initialize_by(student_id: student_id,
                                                                      section_id: section_id,
                                                                      ref_id: element['refId'])
    student_section.student_ref_id = element['studentRefId']
    student_section.section_ref_id = element['sectionRefId']
    student_section.school_year = element['schoolYear']
    student_section.exit_date = element['exitDate']
    puts 'Student section!' if student_section.save
  end
end

def seed_assignments
  # Something's not right with the response
  # json = call_api('/assignments', @teacher_headers)
  json = [
 {
   "availableDate" => "2016-06-22T16:40:52.000Z",
   "students" => [
     {
       "studentRefId" => "0c127e7b-3b97-4d9d-a802-5acbca54097a"
     }
   ],
   "sectionRefId" => "ecbf057b-d0b1-405b-abc9-2a03569fef23",
   "status" => "NOT_STARTED",
   "description" => "Predict the future, communicate with the dead",
   "name" => "Necromancy 101",
   "sourceObjects" => [
     {
       "value" => "09a52b62-f728-4337-a0f4-68c1469f2d89",
       "refObject" => "TEACHER_CREATED"
     }
   ],
   "refId" => "bd1d54c3-4bd6-4a0c-8708-fabe727d0278",
   "creatorRefId" => "ab1d4237-edd7-4edd-934f-3486eac5c262",
   "dueDate" => "2017-07-22T16:40:52.000Z",
   "staffRefId" => "ab1e436e-8177-4139-8e2d-52a6f7a8be27"
 },
 {
   "availableDate" => "2016-06-22T16:40:52.000Z",
   "students" => [
     {
       "studentRefId" => "0c127e7b-3b97-4d9d-a802-5acbca54097a"
     }
   ],
   "sectionRefId" => "ecbf057b-d0b1-405b-abc9-2a03569fef23",
   "status" => "NOT_STARTED",
   "name" => "Necromancy 102",
   "sourceObjects" => [
     {
       "value" => "09a52b62-f728-4337-a0f4-68c1469f2d89",
       "refObject" => "TEACHER_CREATED"
     }
   ],
   "refId" => "f335f82a-1891-4e9c-863a-7113981b032d",
   "creatorRefId" => "ab1d4237-edd7-4edd-934f-3486eac5c262",
   "dueDate" => "2017-07-22T16:40:52.000Z",
   "staffRefId" => "ab1e436e-8177-4139-8e2d-52a6f7a8be27"
 },
 {
   "availableDate" => "2016-06-22T16:40:52.000Z",
   "students" => [
     {
       "studentRefId" => "0c127e7b-3b97-4d9d-a802-5acbca54097a"
     }
   ],
   "sectionRefId" => "ecbf057b-d0b1-405b-abc9-2a03569fef23",
   "status" => "NOT_STARTED",
   "name" => "Necromancy 103",
   "sourceObjects" => [
     {
       "value" => "103",
       "refObject" => "TEACHER_CREATED"
     }
   ],
   "refId" => "ea3aa2d9-64b1-49c6-ab91-26939998b739",
   "creatorRefId" => "ab1d4237-edd7-4edd-934f-3486eac5c262",
   "dueDate" => "2017-07-22T16:40:52.000Z",
   "staffRefId" => "ab1e436e-8177-4139-8e2d-52a6f7a8be27"
 }
]

  json.each do |element|
    assignment = Assignment.find_or_initialize_by(section_ref_id: element['sectionRefId'])
    # assignment.students = element['students']

    # section IDs don't line up in the sample data.
    section_ref_ids = ["6678d699-2434-4825-9aae-a58d168794f8", "931743c5-77de-4c81-8554-5b601ee7d95e", "b5fe79c3-48ab-434c-a212-bf307d000233"]

    assignment.section_id = Section.find_by(ref_id: section_ref_ids.sample).id
    assignment.status = element['status']
    assignment.description = element['description']
    assignment.name = element['name']
    assignment.ref_id = element['refId']
    assignment.creator_ref_id = element['creatorRefId']

    # staff IDs don't line up in the sample data.
    staff_ref_ids = ["0b9cec6d-3e7b-4c8b-8de5-d838db8fabf6",
 "8b48d49e-f32b-47d9-8259-adabad1a081d",
 "ff5c4127-4e10-41d7-84cd-5b9faadb281a",
 "0b9cec6d-3e7b-4c8b-8de5-d838db8fabf6",
 "8b48d49e-f32b-47d9-8259-adabad1a081d",
 "ff5c4127-4e10-41d7-84cd-5b9faadb281a",
 "0b9cec6d-3e7b-4c8b-8de5-d838db8fabf6",
 "8b48d49e-f32b-47d9-8259-adabad1a081d",
 "ff5c4127-4e10-41d7-84cd-5b9faadb281a",
 "0b9cec6d-3e7b-4c8b-8de5-d838db8fabf6",
 "8b48d49e-f32b-47d9-8259-adabad1a081d",
 "ff5c4127-4e10-41d7-84cd-5b9faadb281a",
 "0b9cec6d-3e7b-4c8b-8de5-d838db8fabf6",
 "8b48d49e-f32b-47d9-8259-adabad1a081d",
 "ff5c4127-4e10-41d7-84cd-5b9faadb281a",
 "0b9cec6d-3e7b-4c8b-8de5-d838db8fabf6",
 "8b48d49e-f32b-47d9-8259-adabad1a081d",
 "ff5c4127-4e10-41d7-84cd-5b9faadb281a"]

    assignment.staff_person_id = staff_ref_ids.sample
    assignment.available_date = element['availableDate']
    assignment.due_date = element['dueDate']

    if assignment.save
      puts 'Assignment!'
    else
      puts assignment.errors
    end
  end
end

def seed_assignment_submissions
  # seed with our own data - none available in sample data
  assignments = Assignment.all

  assignments.each do |assignment|
    section = assignment.section
    section_students = section.students

    section_students.each do |student|
      assignment_submission = AssignmentSubmission.find_or_initialize_by(student_id: student.id,
                                                                         assignment_id: assignment.id,
                                                                         ref_id: "someRefID")
      assignment_submission.student_ref_id = student.ref_id
      assignment_submission.assignment_ref_id = assignment.ref_id
      assignment_submission.score = rand(0..100)
      assignment_submission.status = "COMPLETED"

      if assignment_submission.save
        puts "Assignment submission!"
      else
        puts assignment_submission.errors
      end
    end
  end
end

def seed_parents
  first_names = ['John', 'Paul', 'George', 'Oscar', 'Ashley', 'Mary', 'Kate']
  students = Student.all
  students.each do |student|
    first_name = first_names.sample
    parent = Parent.find_or_initialize_by(user_name: first_name + student.family_name,
                                          given_name: first_name,
                                          family_name: student.family_name)
    parent.phone_number = student.phone_number
    parent.email_address = first_name + student.family_name + "@gmail.com"
    puts 'Parent!' if parent.save
    student.parent_id = parent.id
    puts 'Students have parent IDs!' if student.save
  end
end

def seed_users
  parents = Parent.all
  parents.each do |parent|
    user = User.find_or_initialize_by(email: parent.email_address)
    user.password = 'password'
    user.role = 'Parent'
    puts 'Parent users!' if user.save
  end

  teachers = StaffPerson.all
  teachers.each do |teacher|
    user = User.find_or_initialize_by(email: teacher.email_address)
    user.password = 'password'
    user.role = 'Teacher'
    puts 'Teacher users!' if user.save
  end
end

def run_all_seed_methods
  seed_students
  seed_staff
  seed_parents
  seed_sections
  seed_student_sections
  seed_staff_sections
  seed_assignments
  seed_assignment_submissions
  seed_users
end

run_all_seed_methods