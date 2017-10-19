class TicketsController < ApplicationController

  before_action :authenticate_user!

  def index
    @tickets = Ticket.active
  end

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save!
      symbol, message, path = :notice, "Ticket has been created", tickets_path
      TicketsMailer.new_ticket(@ticket).deliver_now
    else
      symbol, message, path = :error, "Something went wrong", tickets_new_path
    end

    respond_to do |format|
      format.html do
        flash[symbol] = message
        redirect_to path
      end
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @comment = @ticket.comments.new
  end

  private

  def ticket_params
    params.require(:ticket).permit(:assignee_id, :reporter_id, :subject, :description, :status_id)
  end
end
