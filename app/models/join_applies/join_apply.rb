class JoinApplies::JoinApply < ActiveRecord::Base
  belongs_to :target, polymorphic: true

  validates_presence_of :target_type, :target_id

  validates :email, presence: true,
            format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: 'Email格式不正确' }

  # 医院，药店，药厂，医生，养老院，月子中心，母婴会馆，保险公司 [0..7]
  TARGET_TYPES = %w(Hospitals::Hospital Hospitals::Doctor Drugs::Drugstore Drugs::Manufactory Eldercares::NursingRoom Maternals::ConfinementCenter Maternals::MaternalHall Insurances::Insurance)

  TARGET_TYPES_MAPPING = [{type: 'Hospitals::Hospital', name: '医院'},
                          {type: 'Hospitals::Doctor', name: '医生'},
                          {type: 'Drugs::Drugstore', name: '药店'},
                          {type: 'Drugs::Manufactory', name: '药厂'},
                          {type: 'Eldercares::NursingRoom', name: '母婴会馆'},
                          {type: 'Maternals::ConfinementCenter', name: '月子中心'},
                          {type: 'Maternals::MaternalHall', name: "月子中心"},
                          {type: 'Insurances::Insurance', name: '保险公司'}
                        ]
end
