require 'spec_helper'

describe StudentsController do
  let(:student) { FactoryGirl.create(:student) }
  let(:school) { FactoryGirl.create(:school) }
  let(:day_class) { FactoryGirl.create(:day_class) }
  let(:group) { FactoryGirl.create(:group) }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe "#new" do
    it "returns success" do
      get(:new)
      response.should be_successful
    end
  end

  describe '#create' do
    before(:each) do
      @params = { student: { last_name: "Tyler", first_name: "Rose", grade_level: "6th", school_id: school.id }}
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should redirect_to(new_student_path)
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{Student.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      before(:each) do
        @bad_params = { student: { first_name: "Rose", grade_level: "6th" }}
      end

      it 'renders new' do
        post('create', @bad_params)
        response.should render_template 'new'
      end

      it 'flashes error' do
        post('create', @bad_params)
        flash[:error].should_not be_blank
      end
    end
  end

  describe "#edit" do
    before(:each) do
      Student.stub(:find).and_return(student)
      get('edit', id:student.object_id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @student" do
      assigns(:student).should == student
    end
  end

  describe 'update' do
    before(:each) do
      Student.stub(:find).and_return(student)
    end

    context 'successful update' do
      before(:each) do
        put('update', id:student.object_id)
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
        Student.any_instance.stub(:update_attributes).and_return(nil)
        put('update', id: student.object_id, student: { name: ""})
        response.should render_template 'edit'
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      Student.stub(:find).and_return(student)
    end

    it "redirects upon success" do
      delete('destroy', id:student.object_id)
      response.should be_redirect
    end

    it "destroys the student object" do
      count = Student.count
      delete('destroy', id:student.object_id)
      Student.count.should == count - 1
    end
  end
end