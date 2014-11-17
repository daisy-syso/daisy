SocialSecurities::SocialSecurity.transaction do
  SocialSecurities::SocialSecurity.includes(:province, :city, :social_security_type).each do |r|  
    r.name = "#{(r.city||r.province).name}医保#{r.social_security_type.name}查询"    
    r.save    
  end    
end  