# frozen_string_literal: true
AccessControl.default = AccessControl.build(ActiveSupport::Cache::MemoryStore.new) do
  controller 'static' do
    route 'feed',  level: :anyone
    route 'about', level: :anyone
  end
  
  controller 'users' do
    controller 'registrations' do
      route 'new',    level: :anyone
      route 'create', level: :anyone
    end
    
    controller 'confirmations' do
      route 'new',  level: :anyone
      route 'show', level: :anyone
    end
    
    controller 'sessions' do
      route 'new',     level: :anyone
      route 'create',  level: :anyone
      route 'destroy', level: 0
    end
  end
  
  controller 'profiles' do
    route 'show',   level: :anyone
    route 'edit',   level: 0
    route 'update', level: 0
  end

  controller 'account' do
    route 'edit',   level: 0
    route 'update', level: 0
  end

  controller 'admin' do
    controller 'langtypes' do
      route 'index',  level: 1
      route 'edit',   level: 1
      route 'update', level: 1
    end
  end

  controller 'languages' do
    route 'show',   level: :anyone
    route 'new',    level: 0
    route 'update', level: 0
    route 'create', level: 0
  end

  controller 'preferences' do
    route 'preferences#edit',   level: 0
    route 'preferences#update', level: 0
  end

  controller 'clans' do
    route 'new',     level: 0
    route 'create',  level: 0
    route 'show',    level: :anyone
    route 'index',   level: :anyone
    route 'join',    level: 0
    route 'primary', level: 0
  end
end
