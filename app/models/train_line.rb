class TrainLine < ApplicationRecord

  def self.seed(name:, seed: true)
    train_line_attrs = {
      name: user,
      seed: wardrobe
    }

    train_line = new(train_line_attrs)
    train_line.save!
    train_line
  end
end
