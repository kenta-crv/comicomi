Rails.application.routes.draw do

  #管理者アカウント
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }

  resources :admins, only: [:show]
  #使用者アカウント
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: [:show]

  resources :admins, only: [:show]
  #ワーカーアカウント
  devise_for :workers, controllers: {
    registrations: 'workers/registrations',
    sessions: 'workers/sessions',
    confirmations: 'workers/confirmations',
    passwords: 'workers/passwords',
  }
  resources :workers, only: [:show]
  #メンバーアカウント
  devise_for :members, controllers: {
    registrations: 'members/registrations',
    sessions: 'members/sessions',
    confirmations: 'members/confirmations',
    passwords: 'members/passwords',
  }
  #devise_scope :member do
  #   get 'members/thanks' => 'members/registrations#thanks'
   #end
   # devise_scopeで設定しないと、request.env[“devise.mapping”]でroutesの設定がされない
   #def devise_scope(scope)
    # constraint = lambda do |request|
    #   request.env["devise.mapping"] = Devise.mappings[scope]
    #   true
     #end
     #constraints(constraint) do
    #   yield
    # end
   #end
  resources :members, only: [:show]

  root to: 'top#index' #トップページ
  #各種LPページ
  get 'guide' => 'top#guide' #企業側LP
  #特集
  get 'special' => 'top#special'
  get 'faq' => 'top#faq'
  get 'co' => 'top#co'
  get 'question' => 'top#question'
  #企業側アカウント
  resources :companies do
    collection do
      get :pay
      post :get_point
      post :confirm
      post :thanks
    end
  end

  #記事一覧
  resources :posts
  #企業HP一覧
  resources :lists do
    collection do
      post :import
    end
  end
  resources :estimates do
    collection do
      post :confirm
      post :thanks
    end
    member do
      get :apply
    end
  end

  # メッセージ
  resources :messages, only: [:create] do
    collection do
      # メッセージルーム
      get :room, path: '/room/:uri_token'
    end
  end

  #問い合わせフォーム
  get '/contact' => 'contact#index'
  post '/confirm' => 'contact#confirm'
  post '/thanks' => 'contact#thanks'

  get '*path', controller: 'application', action: 'render_404'
end
