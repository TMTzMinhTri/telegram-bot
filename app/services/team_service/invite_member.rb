module TeamService
  class InviteMember < ApplicationService
    def initialize(current_user:, invitee_email:)
      super
      @current_user = current_user
      @invitee_email = invitee_email
    end

    def call
      raise ArgumentError, 'You cannot invite yourself' if current_user.email == @invitee_email

      team = Team.find_by!(created_by: @current_user)

      User.transaction do
        user = find_or_create_user
        unless user_exists_in_team?(team, user)
          member = team.team_members.build(user:)
          member.save!
          member
        end
      end
    end

    private

    def find_or_create_user
      user = User.find_or_initialize_by(email: @invitee_email)

      if user.new_record?
        user.skip_confirmation!
        user.skip_confirmation_notification!
        user.save!
      end
      user
    end

    def user_exists_in_team?(team, user)
      TeamMember.exists?(team_id: team.id, user_id: user.id)
    end
  end
end
