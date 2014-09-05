class UserInfos::Order < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true

  include Statable

  def name
    "#{item.name} x #{quantity}"
  end

  def total_fee
    price * quantity - discount
  end

  # def pay_url
  #   Alipay::Service.create_partner_trade_by_buyer_url(
  #     :out_trade_no      => id.to_s,
  #     :price             => price,
  #     :quantity          => quantity,
  #     :discount          => discount,
  #     :subject           => name,
  #     :logistics_type    => 'DIRECT',
  #     :logistics_fee     => '0',
  #     :logistics_payment => 'SELLER_PAY',
  #     :return_url        => Rails.application.routes.url_helpers.order_url(self, :host => 'writings.io'),
  #     :notify_url        => Rails.application.routes.url_helpers.alipay_notify_orders_url(:host => 'writings.io'),
  #     :receive_name      => 'none', # 这里填写了收货信息，用户就不必填写
  #     :receive_address   => 'none',
  #     :receive_zip       => '100000',
  #     :receive_mobile    => '100000000000'
  #   )
  # end

  def wap_pay_url
    options = {
      :req_data => {
        :out_trade_no  => id.to_s,
        :price         => price,
        :quantity      => quantity,
        :discount      => discount,
        :subject       => name,
        :total_fee     => 'TOTAL_FEE',
        :notify_url    => 'http://www.syso.com.cn/api/order/done',
        :call_back_url => 'http://www.syso.com.cn/mobile/order/done.html'
      }
    }
    token = Alipay::Service::Wap.trade_create_direct_token(options)
    Alipay::Service::Wap.auth_and_execute(request_token: token)
  end

  # def send_good
  #   Alipay::Service.send_goods_confirm_by_platform(
  #     :trade_no => trade_no,
  #     :logistics_name => 'writings.io',
  #     :transport_type => 'DIRECT' # 无需物流
  #   )
  # end
end