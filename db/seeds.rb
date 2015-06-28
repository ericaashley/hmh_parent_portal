# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
API_URL = 'http://sandbox.api.hmhco.com/v1'

@teacher_headers = {
  "Content-Type"=> "application/json",
  "Accept" => "text/json",
  "Vnd-HMH-Api-Key"=> "1ae6629a8d64d165196a81c8ff43593b",
  "Authorization"=> "SIF_HMACSHA256 ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJsa1pXNTBhWFI1TG1Gd2FTNW9iV2hqYnk1amIyMGlMQ0poZFdRaU9pSm9kSFJ3T2k4dmQzZDNMbWh0YUdOdkxtTnZiU0lzSW1saGRDSTZNVFF6TlRRME9ERXlNU3dpYzNWaUlqb2lZMjVjZFRBd00yUlRZWFZ5YjI0Z1FtRnlZV1JrZFhJc2RXbGtYSFV3TUROa2MyRjFjbTl1TEhWdWFYRjFaVWxrWlc1MGFXWnBaWEpjZFRBd00yUmhZakZsTkRNMlpTMDRNVGMzTFRReE16a3RPR1V5WkMwMU1tRTJaamRoT0dKbE1qY3NaR05jZFRBd00yUXhJaXdpYUhSMGNEb3ZMM2QzZHk1cGJYTm5iRzlpWVd3dWIzSm5MMmx0YzNCMWNtd3ZiR2x6TDNZeEwzWnZZMkZpTDNCbGNuTnZiaUk2V3lKSmJuTjBjblZqZEc5eUlsMHNJbU5zYVdWdWRGOXBaQ0k2SWpWbU1qTTVaalpsTFRneE5UUXROREl3T1MwNVpEbGtMVFZrWlRFeVkyRTBPR1ZrWmk1b2JXaGpieTVqYjIwaUxDSmxlSEFpT2pFME16VTBOVEUzTWpGOS5tRkJaNTliR1c4eVlOUDVpMHhZc2dvUS14a1Y3SjNvd2JhaVktMVhPdlZrOnIrT045aERWSXE0VVUwVHdQejhwSVl5Um5ralJtZFpQeXNRUlBIZW5lZzA9Cg=="
}

@student_headers = {
  "Content-Type"=> "application/json",
  "Accept" => "text/json",
  "Vnd-HMH-Api-Key"=> "1ae6629a8d64d165196a81c8ff43593b",
  "Authorization"=> "SIF_HMACSHA256 ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJsa1pXNTBhWFI1TG1Gd2FTNW9iV2hqYnk1amIyMGlMQ0poZFdRaU9pSm9kSFJ3T2k4dmQzZDNMbWh0YUdOdkxtTnZiU0lzSW1saGRDSTZNVFF6TlRRME9ERXlNU3dpYzNWaUlqb2lZMjVjZFRBd00yUlRZWFZ5YjI0Z1FtRnlZV1JrZFhJc2RXbGtYSFV3TUROa2MyRjFjbTl1TEhWdWFYRjFaVWxrWlc1MGFXWnBaWEpjZFRBd00yUmhZakZsTkRNMlpTMDRNVGMzTFRReE16a3RPR1V5WkMwMU1tRTJaamRoT0dKbE1qY3NaR05jZFRBd00yUXhJaXdpYUhSMGNEb3ZMM2QzZHk1cGJYTm5iRzlpWVd3dWIzSm5MMmx0YzNCMWNtd3ZiR2x6TDNZeEwzWnZZMkZpTDNCbGNuTnZiaUk2V3lKSmJuTjBjblZqZEc5eUlsMHNJbU5zYVdWdWRGOXBaQ0k2SWpWbU1qTTVaalpsTFRneE5UUXROREl3T1MwNVpEbGtMVFZrWlRFeVkyRTBPR1ZrWmk1b2JXaGpieTVqYjIwaUxDSmxlSEFpT2pFME16VTBOVEUzTWpGOS5tRkJaNTliR1c4eVlOUDVpMHhZc2dvUS14a1Y3SjNvd2JhaVktMVhPdlZrOnIrT045aERWSXE0VVUwVHdQejhwSVl5Um5ralJtZFpQeXNRUlBIZW5lZzA9Cg=="
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
  binding.pry
  json.each do |element|

end
seed_sections