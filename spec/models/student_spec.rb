require 'spec_helper'

describe Student do
  let(:student) { FactoryGirl.create(:student) }

  it { should have_many(:student_groups).dependent(:destroy) }
  it { should have_many :groups }
  it { should have_many(:student_assignments).dependent(:destroy) }
  it { should have_many :assignments }
  it { should have_many(:student_day_classes).dependent(:destroy) }
  it { should have_many :day_classes }
  it { should belong_to :school }

  it { should accept_nested_attributes_for :student_groups }
  it { should accept_nested_attributes_for :student_day_classes }


  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :grade_level }

  describe "#name" do
    it "returns a name" do
      student.name.should eq("Betty Rubble")
    end
  end
end
