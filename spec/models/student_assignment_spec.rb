require 'spec_helper'

describe StudentAssignment do

  it { should belong_to :student }
  it { should belong_to :assignment }

end
