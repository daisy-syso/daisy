class Order < ActiveRecord::Base

  STATE = %w(opening pending paid completed canceled)
  validates_inclusion_of :state, :in => STATE

  # 添加 paid? completed? 等方法
  STATE.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  # 状态迁移方法
  def pend
    update_attribute :state, 'pending' if opening?
  end

  # 只在 pending 状态可以 pay
  def pay
    update_attribute :state, 'paid' if pending?
  end

  # 只在 pending 和 paid 状态可以 complete
  def complete
    update_attribute :state, 'completed' if pendding? or paid?
  end

  # 只在 pending 和 paid 状态可以 cancel
  def cancel
    update_attribute :state, 'canceled' if pendding? or paid?
  end

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