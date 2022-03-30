class SlotPolicy < ApplicationPolicy
  # def update?
  #   user.admin? or not record.published?
  # end
  def create?
    !!user
  end
  def update?
    create?
  end
  def show?
    !!user
  end
end
