class TeamMailer < ApplicationMailer
  def invitation_instructions
    member = params[:member]
    p '----------------------------------------------------------------'
    p '----------------------------------------------------------------'
    p '----------------------------------------------------------------'
    p '----------------------------------------------------------------'
    # @token = member.invitation_token
    # @sender =
    debugger
    # mail(header_for('invitation',
    #                 sender: @sender, reciver:))
  end
end
