class JoinApplies::JoinApply < ActiveRecord::Base
  belongs_to :target, polymorphic: true

  validates_presence_of :target_type, :target_id

  validates :email, presence: true,
            format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: 'Email格式不正确' }

  # 医院，药店，药厂，医生，养老院，月子中心，母婴会馆，保险公司 [0..7]
  TARGET_TYPES = %w(Hospitals::Hospital Hospitals::Doctor Drugs::Drugstore Drugs::Manufactory Eldercares::NursingRoom Maternals::ConfinementCenter Maternals::MaternalHall Insurances::Insurance)
end
