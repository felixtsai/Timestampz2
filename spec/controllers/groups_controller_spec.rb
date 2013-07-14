require 'spec_helper'

describe GroupsController do
  let(:group) { FactoryGirl.create(:group) }

  before :each do
    sign_in
  end

  describe "#new" do
    it "returns success" do
      get('new')
      response.should be_successful
    end
  end

  describe "#create" do
    context 'with correct params' do
      before(:each) do
        @params = { group: { id: group.object_id, name: group.name, teacher_last_name: group.teacher_last_name,
                    teacher_first_name: group.teacher_first_name }}
      end

      it 'redirects' do
        post('create', @params)
        response.should be_redirect
      end

      it 'saves a Group object' do
        num_groups = Group.count
        post('create', @params)
        Group.count.should == num_groups + 1
      end

      it 'has sucessful flash notice' do
        post('create', @params)
        flash[:success].should_not be_blank
      end
    end

    context 'with incorrect params' do
      it 'renders new' do
        post('create')
        response.should render_template 'new'
      end
    end
  end
  
  describe "#index" do
    it "returns success" do
      get('index')
      response.should be_successful
    end

    it "assigns @groups" do
      mock_group = double("groups")
      Group.stub(:by_teacher).and_return(mock_group)
      get('index')
      assigns(:groups).should == mock_group
    end
  end

  describe "#show" do
    before(:each) do
      Group.stub(:find).and_return(group)
    end

    it "returns success" do
      get('show', id:group.object_id)
      response.should be_successful
    end

    it "assigns @group" do
      get('show', id:group.object_id )
      assigns(:group).should == group
    end
  end

  describe "#edit" do
    before(:each) do
      Group.stub(:find).and_return(group)
    end

    it "returns success" do
      get('edit', id:group.object_id)
      response.should be_successful
    end

    it "assigns @group" do
      get('edit', id:group.object_id)
      assigns(:group).should == group
    end
  end

  describe 'update' do
    before(:each) do
      Group.stub(:find).and_return(group)
    end

    context 'successful update' do
      it 'redirects upon success' do
        put('update', id:group.object_id)
        response.should be_redirect
      end

      it 'flashes a success message' do
        put('update', id: group.object_id)
        flash[:success].should_not be_blank
      end
    end

    context 'unsuccessful update' do
      it 'renders edit' do
        put('update', id: group.object_id, group: { name: ""})
        response.should render_template 'edit'
      end
    end
  end

  describe "#destroy" do
    before(:each) do
      Group.stub(:find).and_return(group)
    end

    it "redirects upon success" do
      delete('destroy', id:group.object_id)
      response.should be_redirect
    end

    it "destroys the group object" do
      count = Group.count
      delete('destroy', id:group.object_id)
      Group.count.should == count - 1
    end
  end
end
