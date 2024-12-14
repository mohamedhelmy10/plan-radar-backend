require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  # Create sample data
  let!(:user) { create(:user) }
  let!(:status) { Status.find_or_create_by(name: :pending) }
  let!(:ticket) { create(:ticket, assigned_user: user, status: status) }

  # Test Index action
  describe "GET #index" do
    it "assigns @tickets" do
      get :index
      expect(assigns(:tickets)).to eq([ticket])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  # Test Show action
  describe "GET #show" do
    it "assigns the requested ticket to @ticket" do
      get :show, params: { id: ticket.id }
      expect(assigns(:ticket)).to eq(ticket)
    end

    it "renders the show template" do
      get :show, params: { id: ticket.id }
      expect(response).to render_template(:show)
    end
  end

  # Test New action
  describe "GET #new" do
    it "assigns a new ticket to @ticket" do
      get :new
      expect(assigns(:ticket)).to be_a_new(Ticket)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  # Test Create action
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new ticket" do
        expect {
          post :create, params: { ticket: { title: "New Ticket", description: "A new ticket", due_date: "2024-12-31", assigned_user_id: user.id, status_id: status.id } }
        }.to change(Ticket, :count).by(1)
      end

      it "redirects to the show page of the new ticket" do
        post :create, params: { ticket: { title: "New Ticket", description: "A new ticket", due_date: "2024-12-31", assigned_user_id: user.id, status_id: status.id } }
        expect(response).to redirect_to(ticket_path(Ticket.last))
      end
    end

    context "with invalid attributes" do
      it "does not create a new ticket" do
        expect {
          post :create, params: { ticket: { title: nil, description: "A new ticket", due_date: "2024-12-31", assigned_user_id: user.id, status_id: status.id } }
        }.not_to change(Ticket, :count)
      end

      it "re-renders the new template" do
        post :create, params: { ticket: { title: nil, description: "A new ticket", due_date: "2024-12-31", assigned_user_id: user.id, status_id: status.id } }
        expect(response).to render_template(:new)
      end
    end
  end

  # Test Edit action
  describe "GET #edit" do
    it "assigns the requested ticket to @ticket" do
      get :edit, params: { id: ticket.id }
      expect(assigns(:ticket)).to eq(ticket)
    end

    it "renders the edit template" do
      get :edit, params: { id: ticket.id }
      expect(response).to render_template(:edit)
    end
  end

  # Test Update action
  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the ticket" do
        patch :update, params: { id: ticket.id, ticket: { title: "Updated Ticket" } }
        ticket.reload
        expect(ticket.title).to eq("Updated Ticket")
      end

      it "redirects to the show page of the updated ticket" do
        patch :update, params: { id: ticket.id, ticket: { title: "Updated Ticket" } }
        expect(response).to redirect_to(ticket_path(ticket))
      end
    end

    context "with invalid attributes" do
      it "does not update the ticket" do
        patch :update, params: { id: ticket.id, ticket: { title: nil } }
        ticket.reload
        expect(ticket.title).not_to be_nil
      end

      it "re-renders the edit template" do
        patch :update, params: { id: ticket.id, ticket: { title: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  # Test Destroy action
  describe "DELETE #destroy" do
    it "deletes the ticket" do
      expect {
        delete :destroy, params: { id: ticket.id }
      }.to change(Ticket, :count).by(-1)
    end

    it "redirects to the tickets index page" do
      delete :destroy, params: { id: ticket.id }
      expect(response).to redirect_to(tickets_path)
    end
  end
end
