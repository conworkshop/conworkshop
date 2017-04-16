class RouteAccessControl < ApplicationRecord
  GUEST_LEVEL       = -1
  MAINTENANCE_LEVEL = 99

  def allowed?(user)
    return true if anyone?

    maintenance? && user&.group == ?D || user&.rank?(level)
  end

  def anyone?
    level == GUEST_LEVEL
  end

  def maintenance?
    level == MAINTENANCE_LEVEL
  end
end
