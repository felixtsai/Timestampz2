require 'spec_helper'

describe Teacher do

  it { should have_many(:day_classes) }
  it { should belong_to(:school) }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :school_id }
end
