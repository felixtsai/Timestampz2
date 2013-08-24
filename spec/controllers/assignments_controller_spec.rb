require 'spec_helper'

describe AssignmentsController do
  let(:assignment) { FactoryGirl.create(:assignment) }
  let(:day_class) { FactoryGirl.create(:day_class) }
  let(:user) { FactoryGirl.create(:user) }

  before :each do
    sign_in
  end

  describe '#index' do
    before :each do
      get :index
    end

    it 'assigns assignments' do
      expect(assigns(:assignments)).to eq([assignment])
    end

    it 'assigns day_classes' do
      expect(assigns(:day_classes)).to eq(DayClass.by_name)
    end

    it 'renders index page' do
      expect(response).to render_template("index")
    end
  end

  describe '#new' do
    before :each do
      get :new
    end

    it 'has a route' do
      expect(response).to be_successful
    end

    it 'assigns @assignment' do
      expect(assigns(:assignment)).to be_a_new(Assignment)
    end

    it 'assigns @day_classes' do
      expect(assigns(:day_classes)).to eq(DayClass.by_name)
    end
  end

  describe '#create' do

    before :each do
      ApplicationController.any_instance.stub(:current_user).and_return()
      @params = { assignment: { '0' => { name: "Assignment 1", due_date: Time.now, day_class_id: day_class.id }}}
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should redirect_to(assignments_path)
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{Assignment.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      it 'flashes error' do
        Assignment.any_instance.stub(:save).and_return(nil)
        Assignment.any_instance.stub_chain(:errors, :full_messages).and_return(["Error"])
        post('create', @params)
        flash[:errors].should_not be_blank
      end
    end
  end

  describe '#edit' do
    before :each do
      get :edit, id: assignment.id
    end

    it 'has a route' do
      expect(response).to be_successful
    end

    it 'assigns @assignment' do
      expect(assigns(:assignment)).to eq(assignment)
    end

    it 'assigns @day_classes' do
      expect(assigns(:day_classes)).to eq(DayClass.by_name)
    end
  end

  describe '#update' do

    it 'changes assignments attributes' do
      assignment_attributes = {
        name: 'new name'
      }
      post :update, id: assignment.id, assignment: { '0' => assignment_attributes }
      Assignment.first.name.should == 'new name'
    end

    it 'redirects to index' do
      post :update, id: assignment.id, assignment: { '0' => {} }
      expect(response).to redirect_to(assignments_path)
    end
  end

  describe '#destroy'do

    it 'deletes an assignment' do
      assignment
      expect{
        delete :destroy, id: assignment.id
      }.to change{Assignment.count}.by(-1)
    end

    it 'redirects to index' do
      delete :destroy, id: assignment.id
      expect(response).to redirect_to(assignments_path)
    end
  end
end