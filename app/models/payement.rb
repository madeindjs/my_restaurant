class Payement < ApplicationRecord
  belongs_to :product

  validates_presence_of :product_id
  validates_presence_of :user_id


  def paypal_url return_path

    values = {
        business: Rails.application.secrets.paypal_business_mail,
        cmd: "_xclick",
        upload: 1,
        return: return_path,
        invoice: id,
        amount: product.price,
        currency_code: 'EUR',
        item_name: product.name,
        item_number: product.id,
        quantity: 1,
        notify_url: Rails.application.routes.url_helpers.payement_hook_url(host: Rails.application.secrets.app_host)

    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


  def complete_address
    "#{address_street}, #{address_zip}, #{address_city}, #{address_country}"
  end

end