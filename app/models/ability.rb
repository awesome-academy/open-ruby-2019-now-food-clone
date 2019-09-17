class Ability
  include CanCan::Ability

  def initialize user
    can :read, District
    can :read, Province
    can :read, Store
    can :read, Product
    can :read, Combo

    if user.present?
      if user.admin?
        can [:read, :create], User
        can :update, User, role: Settings.account.manager.role
        can :destroy, User, role: [Settings.account.user.role, Settings.account.manager.role]
      elsif user.manager?
        can :manage, Store, user_id: user.id
        can :create, Combo
        can [:read, :update, :destroy], Combo, id: user.combo_ids
        can :create, Product
        can [:read, :update, :destroy], Product, id: user.product_ids
        can :mamage, [ComboProduct, Comment]
        can [:read, :update], Bill, store: {id: user.store_ids}
      else
        can [:read, :create], Bill, user_id: user.id
        can [:read, :create], BillDetail, bill_detail: {bill: {user_id: user.id}}
      end
    end
  end
end
