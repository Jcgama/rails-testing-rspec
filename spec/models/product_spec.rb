require 'rails_helper'
require_relative '../support/utilities.rb'

describe Product do
    subject { FactoryGirl.build(:product) }
    
    
    it "should be valid" do
       expect(subject).to be_valid 
    end
    
    it "should not be valid absent title" do
       subject.title = nil
       expect(subject).to_not be_valid
    end
    
    it "should not be valid absent description" do
       subject.description = nil
       expect(subject).to_not be_valid
    end
    
    it "should not be valid absent price" do
       subject.price = nil
       expect(subject).to_not be_valid
    end
    
    it "should not be valid with price lower than 0.01" do
       subject.price = 0
       expect(subject).to_not be_valid
    end
    
    it "should have an unique title" do
        subject.save
        foo = FactoryGirl.build(:product)
        expect(foo).to_not be_valid
    end
    
    it "should have a valid format for image" do
        valid_formats.each do |valid|
           subject.image_url = "foo." + valid
           expect(subject).to be_valid
        end
    end
    
    it "should not accept invalid formats for image" do
       invalid_formats.each do |invalid|
          subject.image_url = "foo." + invalid
          expect(subject).to_not be_valid
       end
    end
    
end