require 'spec_helper'

describe StudentGroup do

  it { should belong_to :student }
  it { should belong_to :group }

end
