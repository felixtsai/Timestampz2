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

  	it 'renders index page' do
  		expect(response).to render_template("index")
  	end
  end

  describe '#create' do

    before :each do
      ApplicationController.any_instance.stub(:current_user).and_return()
      @assignment_hash = {
        name: "Assignment 1",
        due_date: Time.now,
        day_class_id: day_class.id
      }
    end

    context 'it saves to the database' do

      it 'creates a new assignment' do
        expect{
          post :create, assignment: @assignment_hash 
        }.to change{Assignment.count}.by(1)
      end

      it 'redirects to index' do
        post :create, assignment: @assignment_hash
        expect(response).to redirect_to(assignments_path) 
      end
    end

    context 'it does not save' do
      it 'renders new' do
        post :create, assignment: {due_date: Time.now}
        expect(response).to redirect_to(new_assignment_path)
      end
    end

  end

  describe '#update' do

    it 'changes assignments attributes' do
      assignment_attributes = {
        name: 'new name'
      }
      post :update, id: assignment.id, assignment: assignment_attributes
      Assignment.first.name.should == 'new name'
    end

    it 'redirects to index' do
      post :update, id: assignment.id
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