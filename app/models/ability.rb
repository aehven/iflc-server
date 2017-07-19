class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role
      when "admin"
        can :manage, :all

      # when "manager"
      #   can [:read, :update, :create], User

      when "regular"
        can [:read, :update], User, id: user.id
        can :manage, Account
        can :manage, Contact
        can :manage, Favorite
        can :manage, Activity
    end
  end

  #might need to know permissions on client side for things like displaying of Edit buttons.
  #the server would reject an attempt to update a record, but best to avoid allowing it on
  #the client first.
  #as_json thanks to: https://gist.github.com/mewdriller/4980855
  def as_json
    abilities = []
    rules.each do |rule|
      abilities << { can: rule.base_behavior, actions: rule.actions.as_json, subjects: rule.subjects.map(&:to_s), conditions: rule.conditions.as_json }
    end
    abilities
  end

end
