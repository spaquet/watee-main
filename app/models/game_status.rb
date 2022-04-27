class GameStatus < ApplicationRecord
  before_create :generate_unique_pin

  validates presence: :game_mgr_id
  validates presence: :game_id
  validates presence: :pin, uniqueness: true

  enum status: {started: 0, inprogress: 10, ended: 20}

  private

  # Generate a unique pin of 6 digits as a string
  def generate_unique_pin
    begin
      self.pin = 6.times.map { rand(0..9) }.join
    end while GameStatus.exists?(pin: self.pin)
  end

end
