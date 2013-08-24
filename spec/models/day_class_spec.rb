require 'spec_helper'

describe DayClass do
  let(:day_class) { FactoryGirl.build(:day_class) }

  it { should have_many :student_day_classes }
  it { should have_many :students }
  it { should have_many :assignments }
  it { should belong_to :school }
  it { should belong_to :teacher }
  it { should validate_presence_of :subject }
  it { should validate_presence_of :period }

  describe '#get_name' do
    it 'generates a class name' do
      day_class.get_name.should eq("Flintstone's 3rd period Math")
    end
  end

  describe 'before_save' do
    it 'generates a name and saves it' do
      day_class.name.should eq(nil)
      day_class.save
      day_class.name.should eq("Flintstone's 3rd period Math")
    end
  end
end
