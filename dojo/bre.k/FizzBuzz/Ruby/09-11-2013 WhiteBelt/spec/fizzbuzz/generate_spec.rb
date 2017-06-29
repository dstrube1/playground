require 'spec_helper'

module FizzBuzz
	describe Generate do
		let(:output) {double('output').as_null_object}
		let(:fizzbuzz) {Generate.new(output)}
		describe "#start" do
			it "sends a welcome message" do
				output.should_receive(:puts).with('This is FizzBuzz')
				fizzbuzz.start
			end
			it "calls response method" do
				fizzbuzz.should_receive(:response).exactly(100).times
				fizzbuzz.start
			end
		end
		describe "#response" do
			context "input divisible by 3" do
				it "returns 'Fizz'" do
					fizzbuzz.response(3).should eq "Fizz"
				end
			end
			context "input divisble by 5" do
				it "returns 'Buzz'" do
					fizzbuzz.response(5).should eq "Buzz"
				end
			end
			context "input divisible by 3 and 5" do
				it "returns 'FizzBuzz'" do
					fizzbuzz.response(15).should eq "FizzBuzz"
				end
			end
			context "input any other integer" do
				describe "input is 1" do
					it "returns 1" do
						fizzbuzz.response(1).should eq "1"
					end
				end
			end
			context "input not integer" do
				describe "input is a character" do
					it "produces not an integer error" do
						expect { fizzbuzz.response('a') }.to raise_error "Must be a positive integer!"
					end
				end
				describe "input is a floating point number" do
					it "produces not an integer error" do
						expect { fizzbuzz.response('1.1') }.to raise_error "Must be a positive integer!"
					end
				end
			end
			context "input not positive" do
				it "produces not positive error" do
					expect { fizzbuzz.response('-1') }.to raise_error "Must be a positive integer!"
				end
			end
		end
	end
end