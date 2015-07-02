require_relative '../lib/parkinglot'

describe ParkingLot do

	before do 
		@parking_lot = ParkingLot.new
		@parking_lot.park(["KL-12-0214", "red"])
		@parking_lot.park(["KL-82-0287", "red"])
		@parking_lot.park(["KL-04-2355", "white"])
		@parking_lot.park(["KL-05-9865", "white"])
	end
	describe "#create_parking_lot" do
    it "creates a parkinglot with 5 slotes" do
      expect(@parking_lot.create_parking_lot([5])).to eq "Created a parking lot with 5 slots\n\n"
    end
	end

	describe "#park" do
    it "park car with a given color and registration number" do
      expect(@parking_lot.park(["KL-02-1234", "white"])).to eq "Allocated slot number: 5\n\n"
    end
	end

	describe "#leave" do
    it "removes the car with given slot number" do
      expect(@parking_lot.leave([1])).to eq "Slot number 1 is free\n\n"
    end
	end

	describe "#status" do
    it "gives status" do
      expect(@parking_lot).to respond_to(:status)
    end
	end

	describe "#registration_numbers_for_cars_with_colour" do
    it "list registration numbers of cars with given color" do
      expect(@parking_lot.registration_numbers_for_cars_with_colour(['white'])).to eq "KL-04-2355, KL-05-9865, KL-02-1234\n\n"
    end
	end

	describe "#slot_numbers_for_cars_with_colour" do
    it "list slot numbers of cars with given color" do
      expect(@parking_lot.slot_numbers_for_cars_with_colour(['white'])).to eq "3, 4, 5\n\n"
    end
	end

	describe "#slot_number_for_registration_number" do
    it "slot number of car with given registration number" do
      expect(@parking_lot.slot_number_for_registration_number(['KL-82-0287'])).to eq "2\n\n"
    end
	end
 
end
