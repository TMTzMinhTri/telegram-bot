class TeamMailer < ApplicationMailer
  def invitation_instructions
    member = params[:member]
    @token = member.invitation_token
  end
end
