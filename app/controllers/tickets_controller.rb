class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy]

  # GET /tickets
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @users = User.all
    @statuses = Status.all
  end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render :new
    end
  end

  # GET /tickets/:id
  def show
  end

  # GET /tickets/:id/edit
  def edit
    @users = User.all
    @statuses = Status.all
  end

  # PATCH/PUT /tickets/:id
  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tickets/:id
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description, :due_date, :assigned_user_id, :status_id, :progress)
  end
end
