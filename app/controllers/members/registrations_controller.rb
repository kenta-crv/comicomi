# frozen_string_literal: true
class Members::RegistrationsController < Devise::RegistrationsController #deviseの該当クラスを継承させる
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_up_path_for(resource)
    "/companies/new"
  end

  #def thanks
  #end

  #def after_inactive_sign_up_path_for(resource) # 以下コメントアウトを外してよしなに追加
  #  members_thanks_path
  #end
  def create
    super do
      resource.update(confirmed_at: Time .now.utc)
    end
  end

  #登録時のスキップ機能
def skip_confirmation!
  self.confirmed_at = Time.now.utc
end

#更新時のスキップ機能
def skip_reconfirmation!
  @bypass_confirmation_postpone = true
end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
    devise_parameter_sanitizer.permit(:account_update)#追記
  end

  # POST /resource

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
