require 'spec_helper'

describe SchoolsController do
  let(:school) { FactoryGirl.create(:school) }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe "#new" do
    it "returns success" do
      get('new')
      response.should be_successful
    end
  end

  describe '#create' do
    before(:each) do
      @params = { school: { id: school.id, name: "Sequoia" }}
    end

    context 'with correct params' do
      it 'redirects' do
        post(:create, @params)
        response.should be_redirect
      end

      it 'saves to the database' do
        expect{ post :create, @params }.to change{School.count}.by(1)
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'incorrect params' do
      it 'renders new' do
        School.any_instance.should_receive(:save).and_return(nil)
        post('create')
        response.should render_template 'new'
      end
    end
  end

  describe '#index' do
    it 'returns success' do
      get('index')
      response.should be_successful
    end

    it "assigns @schools" do
      mock_schools = double("school")
      School.stub(:by_name).and_return(mock_schools)
      get('index')
      assigns(:schools).should == mock_schools
    end
  end

  describe "#show" do
    before(:each) do
      School.stub(:find).and_return(school)
      get('show', id:school.object_id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @school" do
      assigns(:school).should == school
    end
  end

  describe "#edit" do
    before(:each) do
      School.stub(:find).and_return(school)
      get('edit', id:school.object_id)
    end

    it "returns success" do
      response.should be_successful
    end

    it "assigns @school" do
      assigns(:school).should == school
    end
  end

  describe 'update' do
    before(:each) do
      School.stub(:find).and_return(school)
    end

    context 'successful update' do
      before(:each) do
        put('update', id:school.object_id)
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
        School.any_instance.stub(:update_attributes).and_return(nil)
        put('update', id: school.object_id, school: { name: ""})
        response.should render_template 'edit'
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      School.stub(:find).and_return(school)
    end

    it "redirects upon success" do
      delete('destroy', id:school.object_id)
      response.should be_redirect
    end

    it "destroys the school object" do
      count = School.count
      delete('destroy', id:school.object_id)
      School.count.should == count - 1
    end
  end  
end
