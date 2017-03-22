require 'rails_helper'
require_relative '../support/utilities.rb'

RSpec.describe Product, :type => :model do
    
    subject {
        described_class.new(title: 'Hello, world.', description: 'lorem ipsum', price: 666.00 )
    }
   
   it "should create a valid instance given valid attributes" do
       expect(subject).to be_valid
   end
   
   it "should not be valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
   end
   
   it "should not be valid without a description" do
      subject.description = nil
      expect(subject).to_not be_valid
   end
   
   it "should not be valid without a price" do
      subject.price = nil
      expect(subject).to_not be_valid
   end
   
   it "should not be valid with a price lower than 0.01" do
      subject.price = 0
      expect(subject).to_not be_valid
   end
   
   it "should have an unique title" do
      subject.save
      foo = Product.new(title: 'Hello, world.', description: 'asdf', price: 12.00)
      expect(foo).to_not be_valid
   end
   
   it "should have valid format for image" do
      valid_formats.each do |invalid|
         subject.image_url = "foo" + invalid
         expect(subject).to_not be_valid
      end
   end
   
   it "should accept valid format for image" do
      valid_formats.each do |valid|
         subject.image_url = "foo." + valid
         expect(subject).to be_valid
      end
       
   end
   
end