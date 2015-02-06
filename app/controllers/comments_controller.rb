class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :set_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket] #<co id="ch10_v2_5_1"/>
    else
      flash[:alert] = "Comment has not been created."
      render template: "tickets/show" #<co id="ch10_v2_5_2"/>
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:text) #<co />
  end                                              

end
