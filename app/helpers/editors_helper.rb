module EditorsHelper
  def get_role(role)
    case role
    when 'admin'
      '系统管理员'
    when 'store_owner'
      '药店管理员'
    when 'other'
      '其他人'
    end
  end
end
