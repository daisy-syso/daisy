# 医院、医生、症状、疾病、药品、药企
namespace :elasticsearch do
  desc 'Initialize indexes all'
  task create_indexes_all: :environment do
    def class_string(str)
      str.split("::").inject(Object) do |mod, class_name|
        mod.const_get(class_name)
      end 
    end

    %w(Drugs::Drug Hospitals::Doctor Hospitals::Hospital Diseases::Disease Symptoms::Symptom Drugs::Manufactory Drugs::Drugstore).each do |klass|
      class_string(klass).__elasticsearch__.create_index! force: true
      class_string(klass).import

      puts "#{klass} finished !"
    end
  end

  %w(Drugs::Drug Hospitals::Doctor Hospitals::Hospital Diseases::Disease Symptoms::Symptom Drugs::Manufactory Drugs::Drugstore).each do |es|
    namespace es.to_sym do
      desc "Initialize #{es} indexes"
      task create_indexes: :environment do
        puts "#{es} start !"
        
        Object.const_get(es).__elasticsearch__.create_index! force: true
        
        Object.const_get(es).import

        puts "#{es} finished !"
      end
    end
  end
end