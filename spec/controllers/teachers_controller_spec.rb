require 'spec_helper'

describe TeachersController do
  let(:teacher) { FactoryGirl.create(:teacher) }
  let(:user) { FactoryGirl.create(:user) }
  let(:school) { FactoryGirl.create(:school) }

  before(:each) do
    sign_in user
  end

  describe "#new" do
    it "returns success" do
      get(:new, school_id: school.id)
      response.should be_successful
    end
  end

  describe '#create' do
    before(:each) do
      @params = { teacher: { '0' => { id: teacher.id, first_name: "Sequoia", last_name: "Johnson" }}, school_id: school.id }
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should redirect_to(new_school_day_class_path)
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{Teacher.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      it 'renders new' do
        Teacher.any_instance.stub(:save).and_return(nil)
        Teacher.any_instance.stub_chain(:errors, :full_messages).and_return(["Error"])
        post('create', @params)
        flash[:errors].should_not be_blank
      end
    end
  end

  describe "#edit" do
    before(:each) do
      Teacher.stub(:find).and_return(teacher)
      get('edit', id:teacher.object_id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @teacher" do
      assigns(:teacher).should == teacher
    end
  end

  describe 'update' do
    before(:each) do
      Teacher.stub(:find).and_return(teacher)
    end

    context 'successful update' do
      before(:each) do
        put('update', { id: teacher.id, teacher: { last_name: "O'Reilly" }})
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
        Teacher.any_instance.stub(:update_attributes).and_return(nil)
        put('update', id: teacher.object_id, teacher: { last_name: ""})
        response.should render_template 'edit'
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      Teacher.stub(:find).and_return(teacher)
    end

    it "redirects upon success" do
      delete('destroy', id:teacher.object_id)
      response.should be_redirect
    end

    it "destroys the teacher object" do
      count = Teacher.count
      delete('destroy', id:teacher.object_id)
      Teacher.count.should == count - 1
    end
  end
end
