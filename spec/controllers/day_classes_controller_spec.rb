require 'spec_helper'

describe DayClassesController do
  let(:day_class) { FactoryGirl.create(:day_class) }
  let(:user) { FactoryGirl.create(:user) }
  let(:school) { FactoryGirl.create(:school) }
  let(:teacher) { FactoryGirl.create(:teacher, school_id: school.id ) }

  before(:each) do
    sign_in user
  end

  describe "#new" do
    before :each do
      get(:new, school_id: school.id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @school" do
      expect(assigns(:school)).to eq(school)
    end

    it "assigns @teachers" do
      expect(assigns(:teachers)).to eq(school.teachers)
    end

    it "assigns @day_class" do
      expect(assigns(:day_class)).to be_a_new(DayClass)
    end
  end

  describe '#create' do
    before(:each) do
      @params = { day_class: { '0' => { id: day_class.id, period: "1st", subject: "Math", teacher_id: teacher.id }}, school_id: school.id }
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should redirect_to(schools_path)
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{DayClass.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      it 'flashes error' do
        DayClass.any_instance.stub(:save).and_return(nil)
        DayClass.any_instance.stub_chain(:errors, :full_messages).and_return(["Error"])
        post('create', @params)
        flash[:errors].should_not be_blank
      end
    end
  end

  describe "#edit" do
    before(:each) do
      DayClass.stub(:find).and_return(day_class)
      get('edit', id:day_class.object_id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @day_class" do
      assigns(:day_class).should == day_class
    end
  end

  describe 'update' do
    before(:each) do
      DayClass.stub(:find).and_return(day_class)
    end

    context 'successful update' do
      before(:each) do
        put('update', id:day_class.object_id)
      end
      
      it 'redirects upon success' do
        response.should be_redirect
      end

      it 'flashes a success message' do
        flash[:success].should_not be_blank
      end
    end

    context 'unsuccessful update' do
      it 'renders edit' do
        DayClass.any_instance.stub(:update_attributes).and_return(nil)
        put('update', id: day_class.object_id, day_class: { subject: ""})
        response.should render_template 'edit'
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      DayClass.stub(:find).and_return(day_class)
    end

    it "redirects upon success" do
      delete('destroy', id:day_class.object_id)
      response.should be_redirect
    end

    it "destroys the day_class object" do
      count = DayClass.count
      delete('destroy', id:day_class.object_id)
      DayClass.count.should == count - 1
    end
  end
end
