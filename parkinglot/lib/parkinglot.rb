class Slot
	attr_accessor :slot_number, :registration_number, :color
	def initialize(slot_number)
			@slot_number = slot_number
      @registration_number = nil
      @color = nil
  end

  def slot_creation(registration_number, color)
  	@registration_number = registration_number
    @color = color
  end

  def leave_slot
  	@registration_number = nil
    @color = nil
  end
end

class ParkingLot
	Slots = Array.new

	def create_parking_lot(args)
		no = args[0].to_i
		no.times{|i| Slots << Slot.new(i+1)}
		"Created a parking lot with #{no} slots\n\n"
	end

	def park(args)
		if slot = find_vaccant
			slot.slot_creation(args[0], args[1])
			"Allocated slot number: #{slot.slot_number}\n\n"
		else
			"Sorry, parking lot is full\n\n"
		end
	end

	def leave(args)
		no = args[0].to_i
		slot = Slots.find{|s| s.slot_number==no}
		slot.leave_slot
		"Slot number #{no} is free\n\n"
	end

	def status(args)
		puts "Slot No\tRegistration No Color\n\n"
		slots = Slots.select{|s| s.registration_number}
		arr = []
		slots.each do |slot|
			arr << "#{slot.slot_number}\t#{slot.registration_number}\t#{slot.color}\n\n"
		end
		arr
	end

	def registration_numbers_for_cars_with_colour(args)
		color = args[0]
		if slots = find_by_color(color)
			registration_numbers = slots.map(&:registration_number).join(', ')
			"#{registration_numbers}\n\n"
		end
	end

	def slot_numbers_for_cars_with_colour(args)
		color = args[0]
		if slots = find_by_color(color)
			slot_numbers = slots.map(&:slot_number).join(', ')
			"#{slot_numbers}\n\n"
		end
	end

	def slot_number_for_registration_number(args)
		no = args[0]
		slot = Slots.find{|s| s.registration_number==no}
		if slot
			"#{slot.slot_number}\n\n"
		else
			"Not found\n\n"
		end
	end

	def find_vaccant
		Slots.find{|s| s.registration_number.nil?}
	end

	def find_by_color(color)
		slots = Slots.select{|s| s.color==color}
		if slots.empty?
			puts "Not found\n\n"
			return
		else
			slots
		end
	end
end

class Parking

	def main
		@parkinglot = ParkingLot.new
		methods = ['create_parking_lot', 'park', 'leave', 'status', 'registration_numbers_for_cars_with_colour', 'slot_numbers_for_cars_with_colour', 'slot_number_for_registration_number']
		if ARGV[0]
			File.open(ARGV[0]).each_line do |line|
				args = line.delete("\n").split(' ')
				command = args.delete_at(0)
				puts @parkinglot.public_send(command, args)
			end
		else
			loop do
				input = gets.chomp
				break if input == 'exit'
				args = input.split(' ')
				command = args.delete_at(0)
				unless methods.include?(command)
					puts "Invalid Command"
					next
				end
				puts @parkinglot.public_send(command, args)
			end	
		end
	end
end

# Parking.new.main
