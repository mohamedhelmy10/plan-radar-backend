require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe "GET #index" do
    it "assigns all users to @users" do
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "renders the show template" do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect {
          post :create, params: { user: { name: "Test User", email: "test@example.com" } }
        }.to change(User, :count).by(1)
      end

      it "redirects to the user show page" do
        post :create, params: { user: { name: "Test User", email: "test@example.com" } }
        expect(response).to redirect_to(user_path(assigns(:user)))
      end
    end

    context "with invalid attributes" do
      it "does not create a new user" do
        expect {
          post :create, params: { user: { name: "", email: "invalid_email" } }
        }.to_not change(User, :count)
      end

      it "re-renders the new template" do
        post :create, params: { user: { name: "", email: "invalid_email" } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested user to @user" do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it "renders the edit template" do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the user's attributes" do
        patch :update, params: { id: user.id, user: { name: "Updated Name" } }
        user.reload
        expect(user.name).to eq("Updated Name")
      end

      it "redirects to the user show page" do
        patch :update, params: { id: user.id, user: { name: "Updated Name" } }
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "with invalid attributes" do
      it "does not update the user's attributes" do
        patch :update, params: { id: user.id, user: { name: "" } }
        user.reload
        expect(user.name).to_not eq("")
      end

      it "re-renders the edit template" do
        patch :update, params: { id: user.id, user: { name: "" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users index page" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
