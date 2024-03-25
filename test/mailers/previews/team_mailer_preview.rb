# Preview all emails at http://localhost:3000/rails/mailers/team_mailer
class TeamMailerPreview < ActionMailer::Preview
  def invitation_instructions
    member = TeamMember.first
    TeamMailer.with(member:)
              .invitation_instructions
  end
end
