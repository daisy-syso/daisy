# 医院、医生、症状、疾病、药品、药企

# 药品
Drugs::Drug.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)

# 医生
Hospitals::Doctor.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)

# 医院
Hospitals::Hospital.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)

# 疾病
Diseases::Disease.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)

# 症状
Symptoms::Symptom.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)

# 药企
Drugs::Manufactory.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)

# 药企
Drugs::Drugstore.__elasticsearch__.client = Elasticsearch::Client.new(
  host: Settings.elasticsearch.host, 
  logger: Logger.new(Rails.root.join(Settings.elasticsearch.log ))
)