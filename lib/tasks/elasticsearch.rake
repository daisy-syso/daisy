# 医院、医生、症状、疾病、药品、药企
desc 'index'
task elasticsearch_create_indexes: :environment do
  def class_string(str)
    str.split("::").inject(Object) do |mod, class_name|
      mod.const_get(class_name)
    end 
  end

  %w(Drugs::Drug Hospitals::Doctor Hospitals::Hospital Diseases::Disease Symptoms::Symptom Drugs::Manufactory).each do |klass|
    class_string(klass).__elasticsearch__.create_index! force: true
    class_string(klass).import

    puts "#{klass} finished !"
  end
  
end