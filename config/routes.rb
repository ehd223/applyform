Rails.application.routes.draw do
    #학생 페이지
  root to: 'uviewer#index'
  get '/apply', to: 'uviewer#index'
  get '/apply/uviewer/apply_form', to: 'uviewer#apply_form'
  get '/apply/uviewer/edit_form', to: 'uviewer#edit_form'
  post '/apply/uviewer/apply', to: 'uviewer#apply'
  post '/apply/uviewer/edit', to: 'uviewer#edit'


  #관리자 페이지
  get '/apply/adminviewer', to: 'adminviewer#adminview'
  get '/apply/adminviewer/new', to: 'adminviewer#new'
  post '/apply/adminviewer/create', to: 'adminviewer#create'
  get '/apply/adminviewer/unstarted_list', to: 'adminviewer#unstarted_list'
  get '/apply/adminviewer/ongoing_list', to: 'adminviewer#ongoing_list'
  get '/apply/adminviewer/closed_list', to: 'adminviewer#closed_list'
  get '/apply/adminviewer/export', to: 'adminviewer#export_csv'
  get '/apply/adminviewer/:id/', to: 'adminviewer#show', as: 'post'
  patch '/apply/adminviewer/:id', to: 'adminviewer#update'
  get '/apply/adminviewer/:id/edit', to: 'adminviewer#edit', as: :edit
  delete '/apply/adminviewer/:id/',to: 'adminviewer#destroy'

  #관리자 로그인

  get '/apply/login' => 'session#new'
  post '/apply/login' => 'session#create'
  get '/apply/logout' => 'session#destroy'
  patch '/apply/pwc', to: 'adminviewer#pwc'
  get '/apply/pw_change', to: 'adminviewer#pw_change'

  # resources :poll

end
