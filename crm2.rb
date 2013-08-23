require "contact2"
require "database2"

class CRM

	def initialize(name) #puts a name on new
		@name = name
	end

	def main_menu
		#initialize my main menu method
		print_main_menu
		#method to display options to user
		user_selected = gets.to_i
		#variable created after the method of print_main_menu has run
		call_option(user_selected)
		#starts method call_option and runs an appropriate method based on the variable user_selected
	end
	
	def print_main_menu
		puts "[1] Add a new contact" #available services for user
		puts "[2] Modify a contact" #available services for user
		puts "[3] Delete a contact"
		puts "[4] Display all the contacts"
		puts "[5] Display an attribute" 
		puts "[6] Exit"
		puts "Enter a number:" #prompts user for number which creates the variable of user_selected
	end
	
	def call_option(user_selected) #creates a method that starts one of the user_selected methods
		add_new_contact if user_selected == 1
		modify_existing_contact if user_selected == 2
		delete_contact if user_selected == 3
		display_all_contacts if user_selected == 4
		display_attribute if user_selected == 5
		exit if user_selected == 6
		#return main_menu #repeats method if something other is entered
	end
	
	
	#_______________start of methods____________________
	
	def add_new_contact #process to create a new contact
			print "First Name?"
			@first_name = gets.chomp #acquires input and turns into instance variable
			print "Last Name?"
			@last_name = gets.chomp
			print "Email?"
			@email = gets.chomp
			print "Note?"
			@note = gets.chomp
			contact = Contact.new(@first_name, @last_name, @email, @note)
			Database.add_contact(contact)
			return main_menu
	end
	

#____________delete contact_____________________	
	
	def delete_contact
		print "Enter ID to delete:"
		delete_id = gets.chomp.to_i
		if verify_id(delete_id)
			contact_counter = 0
			Database.contacts.each do |contact|
			Database.contacts.delete_at(contact_counter) if contact.id == delete_id
			contact_counter +=1
		end
		main_menu
		end
	end
	
	#________________verify method_________________________
	
	def verify_id(id)
		Database.contacts.each do |contact|
		return true if contact.id == id
		@modify_contact = contact
		end
		return false
	end
	


#_____________________modify contact _________________________________	
	def modify_existing_contact
		print "Enter ID to modify:"
			modify_id = gets.chomp.to_i
		if verify_id(modify_id)
			contact_counter = 0
			Database.contacts.each do |contact|
					puts "First Name: "+ Database.contacts[contact_counter].first_name
					puts "Last Name: "+ Database.contacts[contact_counter].last_name
					puts "Email:"+ Database.contacts[contact_counter].email
					puts"Note:" + Database.contacts[contact_counter].note
					puts "Are you sure you want to delete? Yes or No"
					delete_confirmation = gets.chomp.downcase
			if delete_confirmation == "yes"
					print "First Name?"
					@new_first_name = gets.chomp #acquires input and turns into instance variable
					@first_name.replace(@new_first_name)
					print "Last Name?"
					@new_last_name = gets.chomp
					@last_name.replace(@new_last_name)
					print "Email?"
					@new_email = gets.chomp
					@email.replace(@new_email)
					print "Note?"
					@new_contact_note = gets.chomp
					@note.replace(@new_contact_note)
					
			return main_menu
			
			elsif delete_confirmation == "no"
				return main_menu
			
			end
		end
				
		else
				"You have entered an invalid response"
				return main_menu
		end
			
	end
	
	
	#_________display all contacts_____________

	def display_all_contacts
		Database.contacts.each do |contact|
		puts "First Name: #{contact.first_name}"
		puts "Last Name: #{contact.last_name}"
		puts "Email: #{contact.email}"
		puts "Note: #{contact.note}"
		puts "ID: #{contact.id}"
		return main_menu
		end
	end
	
	#________display attribute___________
	def display_attribute
		puts "Which attribute would you like to view?"
			puts "[1] First Name" #available services for user
			puts "[2] Last Name" #available services for user
			puts "[3] Email"
			puts "[4] Note"
			puts "[5] ID" 
		attribute_select = gets.chomp.to_i
		Database.contacts.each do |contact|
		
		if attribute_select == 1
			 puts "#{contact.first_name}"
		end
		if attribute_select == 2
			puts "#{contact.last_name}"
		end
		if attribute_select == 3
			puts "#{contact.email}"
		end
		if attribute_select == 4
			puts "#{contact.note}"
		end
		if attribute_select == 5
			 "#{contact.id}"
		end
		
		end
		return main_menu

	end
	
	#________end program_______
	def exit
		return
	end
	
	
	
	crm = CRM.new("my crm") #creates an instance of the class CRM
	crm.main_menu #the instance of crm starts main_menu
	
 

end
