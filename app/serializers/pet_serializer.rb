class PetSerializer < ActiveModel::Serializer
  attributes :name,
             :sex,
             :breed,
             :win_ratio

  def win_ratio
    object.win_ratio
  end

  def sex
    object.sex_humanize
  end

end
