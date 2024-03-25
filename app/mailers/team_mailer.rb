class TeamMailer < ApplicationMailer
  def invitation_instructions
    member = params[:member]
    token = member.invitation_token
    user_info = member.user

    @team_name = member.team.name
    @url = "https://localhost:3002/invitations/#{token}"
    mail(subject: 'Team invitation',
         to: email_address_with_name(user_info.email, user_info.name))
  end
end
