Rails.application.routes.draw do
  root 'events#index'

  scope :static do
  end
  
  scope 'events', controller: 'events' do
    root to: :index, as: :events_index
    get ':id' => :show, as: :events_show
  end

  scope 'tournaments', controller: 'tournaments' do
    get ':id' => :show, as: :tournaments_show
  end

  scope 'fighters', controller: 'fighters' do
    get ':id' => :show, as: :fighters_show
  end

  scope 'users', controller: 'users' do
    root to: :index, as: :users_index
    get 'new' => :new, as: :users_new
    post 'create' => :create, as: :users_create
    get 'show' => :show, as: :users_show
    post 'update' => :update, as: :users_update
  end

  scope 'session', controller: 'sessions' do
    get 'new' => :new, as: :sessions_new
    post 'session' => :create
    delete 'session' => :destroy
  end
end
