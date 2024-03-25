module Endpoints
  class Teams < RootApi
    resources :teams do
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
