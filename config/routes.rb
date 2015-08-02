Rails.application.routes.draw do
  root 'events#index'

  scope :static do
  end
  
  scope 'events', controller: 'events' do
    root to: :index, as: :events_index
    get 'new' => :new, as: :events_new
    get ':id' => :show, as: :events_show
    get ':id/add_tournament' => :add_tournament, as: :add_tournament
    post 'create' => :create, as: :events_create
    delete ':id'=> :destroy, as: :events_destroy
  end

  scope 'tournaments', controller: 'tournaments' do
    get ':id' => :show, as: :tournaments_show
    get ':id/pools' => :tournament_pools, as: :tournament_pools
    get ':id/rules' => :add_rules, as: :tournament_rules
    get ':id/fighters' => :show_fighters, as: :tournament_fighters
    post 'create' => :create, as: :tournaments_create
    post ':id/add_fighter' => :add_fighter, as: :tournaments_add_fighter
    post ':id/create_scores' => :create_scores, as: :tournaments_create_scores
    post ':id/save_pools' => :save_pools, as: :tournaments_save_pools
    delete ':id/remove_fighter' => :remove_fighter, as: :tournaments_remove_fighter
    delete ':id' => :destroy, as: :tournaments_destroy
  end

  scope 'pools', controller: 'pools' do
    get ':id/matches' => :pool_matches, as: :pool_matches
    post 'create' => :create, as: :pools_create
    delete ':id' => :destroy, as: :pools_destroy
  end

  scope 'fighters', controller: 'fighters' do
    get ':id' => :show, as: :fighters_show
  end

  scope 'users', controller: 'users' do
    root to: :index, as: :users_index
    get 'new' => :new, as: :users_new
    get ':id' => :show, as: :users_show
    post 'create' => :create, as: :users_create
    post ':id' => :update, as: :users_update
    delete ':id'=> :destroy, as: :users_destroy
  end

  scope 'session', controller: 'sessions' do
    get 'new' => :new, as: :sessions_new
    post 'session' => :create
    delete 'session' => :destroy
  end
end
