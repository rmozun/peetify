class Pet < ActiveRecord::Base
  belongs_to :user
  has_many :combats_home, :class_name => 'Combat', foreign_key: "fighter1_id"
  has_many :combats_away, :class_name => 'Combat', foreign_key: "fighter2_id"
  has_many :wins, :class_name => 'Combat', foreign_key: "winner_id"

  #enum sex: [:female, :male]
  #validates :sex,_inclusion:{in: Pet.sexes.keys}
  # ARRRGGH: https://github.com/rails/rails/issues/13971
  validates :name, :sex, :breed, presence: true
  validates :age, numericality: true
  validates :name, uniqueness: true
  validates :breed, inclusion: { in: %w(rat dog chinchilla),
    message: "%{value} is not a valid breed" }

  def win_ratio
    self.wins.count.to_f / (self.combats_home.count + self.combats_away.count).to_f
  end

  def sex_humanize
    self.sex==1 ? "male" : "female"
  end

  private
  def pets_params
    # It's mandatory to specify the nested attributes that should be whitelisted.
    # If you use `permit` with just the key that points to the nested attributes hash,
    # it will return an empty hash.
    params.require(:pet).permit(:name, :user, :id)
  end

end
