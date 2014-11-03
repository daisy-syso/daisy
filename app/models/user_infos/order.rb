class UserInfos::Order < ActiveRecord::Base
  belongs_to :account
  belongs_to :item, polymorphic: true

  validates_presence_of :quantity, :price, :discount
  # validates_presence_of :logistics_type, :logistics_name, :logistics_fee, :logistics_payment, :transport_type
  validates_presence_of :receive_name, :receive_address, :receive_zip, :receive_mobile
  validates_numericality_of :quantity, greater_than: 0

  before_validation do
    self.name ||= "#{item.name} x #{quantity}"
    self.price ||= item.ori_price
    self.discount ||= 0
  end

  include Statable

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
    Alipay.pid = '2014103000015061'
    Alipay.key = 'YOUR_KEY'
    Alipay.seller_email = 'YOUR_SELLER_EMAIL'

    options = {
      :req_data => {
        :out_trade_no  => id.to_s,
        :price         => price,
        :quantity      => quantity,
        :discount      => discount,
        :total_fee     => price * quantity - discount,
        :subject       => name,
        :notify_url    => 'http://www.syso.com.cn/api/order/done',
        :call_back_url => 'http://www.syso.com.cn/mobile/order/done.html'
      }
    }
    token = Alipay::Service::Wap.trade_create_direct_token(options)
    p token
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