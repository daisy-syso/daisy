module Statable
  extend ActiveSupport::Concern

  included do
    STATE = %w(opening pending paid completed canceled)
    validates_inclusion_of :state, :in => STATE

    before_validation do
      self.state ||= 'opening'
    end

    # 添加 paid? completed? 等方法
    STATE.each do |state|
      define_method "#{state}?" do
        self.state == state
      end
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

end
