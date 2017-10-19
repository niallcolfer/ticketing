class TicketsMailer < ApplicationMailer
  default from: "ticketingapp@example.com"

  def new_ticket(ticket)
    @user = ticket.assignee
    mail(to: @user.email, subject: ticket.subject)
  end
end
