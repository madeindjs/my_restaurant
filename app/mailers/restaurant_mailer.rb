class RestaurantMailer < ApplicationMailer

  def contact data, restaurant_mail
    @content = data['content']
    @email   = data['email']
    @object  = data['object']
    mail(to: restaurant_mail, subject: @object)
  end

  def commercial restaurant
    @object  = 'Bienvenue sur Fooder'
    @restaurant  = restaurant
    mail(from: 'a.rousseau@fooder.pro', to: restaurant.email, subject: @object)
  end

end
