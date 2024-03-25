module Endpoints
  class Teams < RootApi
    resources :teams do
      parmas do
        requires :email, type: String
      end
      post :intvite_member do
        service = TeamService::InviteMember.call(current_user:, email: declared_params[:email])
        present service
      end
    end
  end
end
