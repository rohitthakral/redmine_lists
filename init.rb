Redmine::Plugin.register :redmine_lists do
  name 'Redmine Lists Plugin'
  author 'Target Integration'
  description 'A plugin to manage custom lists within Redmine'
  version '0.0.1'
  requires_redmine version_or_higher: '5.0.0'

  project_module :lists do
    permission :view_lists, lists: :index
    permission :manage_lists, lists: [:new, :create, :edit, :update, :destroy]
  end
end
