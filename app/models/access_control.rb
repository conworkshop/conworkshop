# frozen_string_literal: true
class AccessControl
  RouteControl = Struct.new(:route, :level) do
    def allowed?(user)
      return true if anyone?

      maintenance? && user&.group == 'D' || user&.rank?(level)
    end

    def anyone?
      level == GUEST_LEVEL
    end

    def maintenance?
      level == MAINTENANCE_LEVEL
    end
  end

  GUEST_LEVEL       = -1
  MAINTENANCE_LEVEL = 99

  def self.build(cache_strategy = Rails.cache, &block)
    new(cache_strategy).tap { |ac| ac.instance_exec(&block) }
  end

  def self.default
    @@default
  end

  def self.default=(ac)
    @@default = ac
  end

  def initialize(cache_strategy = Rails.cache)
    @scope = []
    @cache_strategy = cache_strategy
  end

  def controller(controller, &block)
    @scope.push(controller)

    instance_exec(&block)

    @scope.pop
  end

  def route(route, level: 99)
    scoped_route = resolve_scope(route)
    route_ctl = RouteControl.new(scoped_route, resolve_level(level))

    @cache_strategy.write(cache_key_of(scoped_route), route_ctl)
  end

  def get(route)
    @cache_strategy.read(cache_key_of(route))
  end

  private

  def cache_key_of(route)
    "access-control/#{route}"
  end

  def resolve_scope(route)
    @scope.present? ? "#{@scope.join('/')}##{route}" : route
  end

  def resolve_level(level)
    case level
    when :anyone, :guest then GUEST_LEVEL
    when :maintenance then MAINTENANCE_LEVEL
    else level
    end
  end
end
