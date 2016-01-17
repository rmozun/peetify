class PetPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    return true
  end

  def show?
    return true
  end

  def new?
    return true
  end

  def update?
    return true if record.user == user
  end

  def destroy?
    return true if record.user == user
  end

end
