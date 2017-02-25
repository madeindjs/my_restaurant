class Category < ApplicationRecord
  belongs_to :user


  def self.find_or_create name, user_id
    categories_founded = Category.where(name: name, user_id: user_id)
    if category = categories_founded.first
      return category
    else
      return Category.create name: name, user_id: user_id
    end
  end

end
