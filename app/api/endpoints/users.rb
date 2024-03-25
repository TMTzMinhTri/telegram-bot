module Endpoints
  class Users < RootApi
    resources :users do
      get :me do
      end

      post :login do
      end

      post :register do
      end

      post :forgot_password do
      end

      post :change_password do
      end

      post :reset_password do
      end

      post :resend_email do
      end

      post :delete_account do
      end

      delete :logout do
      end
    end
  end
end
