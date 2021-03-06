Rails.application.routes.draw do
    #학생 페이지
  root to: 'uviewer#index'
  get '/', to: 'uviewer#index'
  get 'uviewer/apply_form', to: 'uviewer#apply_form'
  get 'uviewer/edit_form', to: 'uviewer#edit_form'
  post 'uviewer/apply', to: 'uviewer#apply'
  post 'uviewer/edit', to: 'uviewer#edit'


  #관리자 페이지
  get 'adminviewer', to: 'adminviewer#adminview'
  get 'adminviewer/new', to: 'adminviewer#new'
  post 'adminviewer/create', to: 'adminviewer#create'
  get 'adminviewer/unstarted_list', to: 'adminviewer#unstarted_list'
  get 'adminviewer/ongoing_list', to: 'adminviewer#ongoing_list'
  get 'adminviewer/closed_list', to: 'adminviewer#closed_list'
  get 'adminviewer/export', to: 'adminviewer#export_csv'
  get 'adminviewer/:id/', to: 'adminviewer#show', as: 'post'
  patch 'adminviewer/:id', to: 'adminviewer#update'
  get 'adminviewer/:id/edit', to: 'adminviewer#edit', as: :edit
  delete 'adminviewer/:id/',to: 'adminviewer#destroy'

  #관리자 로그인
  get 'login' => 'session#new'
  post 'login' => 'session#create'
  get 'logout' => 'session#destroy'
  patch 'pwc', to: 'adminviewer#pwc'
  get 'pw_change', to: 'adminviewer#pw_change'

  # resources :poll

end
