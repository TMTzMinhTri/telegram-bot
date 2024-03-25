# Preview all emails at http://localhost:3000/rails/mailers/team_mailer
class TeamMailerPreview < ActionMailer::Preview
  def invitation_instructions
    token = Devise.friendly_token
    UserMailer.with(token, sender_id: 1, reciver: User.last).invitation_instructions
  end
end
