class Combat < ActiveRecord::Base
  belongs_to :fighter1, :class_name => 'Pet', foreign_key: "fighter1_id"
  belongs_to :fighter2, :class_name => 'Pet', foreign_key: "fighter2_id"
  belongs_to :winner, :class_name => 'Pet', foreign_key: "winner_id"

  validates :fighter1, :fighter2, :date, presence: true
  validate :different_owners
  validate :idle_fighters

  def different_owners
    return unless self.fighter1 && self.fighter2
    if self.fighter1.user == self.fighter2.user
        errors.add(:combat, "Fighters belong to the same owner #{self.fighter1.user.name}")
    end
  end

  def idle_fighters
    #no fighter has another combat the same day
    return unless self.fighter1 && self.fighter2 && self.date
    fighter1_fights_in_date = Combat.where("(fighter1_id = ? OR fighter2_id = ?) AND date BETWEEN ? AND ? AND id <> ?",
      self.fighter1_id, self.fighter1_id, self.date.beginning_of_day, self.date.end_of_day, self.id)
    if fighter1_fights_in_date.present?
        errors.add(:combat, "Fighter 1 has another combat the selected day")
    end.inspect
    fighter2_fights__in_date = Combat.where("(fighter1_id = ? OR fighter2_id = ?) AND date BETWEEN ? AND ? AND id <> ?",
      self.fighter2_id, self.fighter2_id, self.date.beginning_of_day, self.date.end_of_day, self.id)
    if fighter2_fights_in_date.present?
        errors.add(:combat, "Fighter 2 has another combat the selected day")
    end
  end

end
