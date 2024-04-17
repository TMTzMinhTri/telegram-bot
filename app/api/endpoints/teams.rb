module Endpoints
  class Teams < RootApi
    resources :teams do
      get do
        owning_teams = current_user.teams
        joining_teams = Team.joins(:team_members).where(team_members: { user_id: current_user.id })

        teams = Team.from("(#{owning_teams.to_sql} UNION #{joining_teams.to_sql}) AS teams")
        teams = teams.includes(:owner)
        present teams, with: Entities::Team
      end
      params do
        requires :email, type: String
      end
      post :intvite_member do
        service = TeamService::InviteMember.call(current_user:, email: declared_params[:email])
        present service
      end

      params do
        requires :a
      end
      post :accept_invitation do
      end

      route_param :token, type: String do
        get :verify_invitation_token do
          team_member = TeamMember.verify_invitation_token(params[:token])
          present team_member
        end
      end
    end
  end
end
