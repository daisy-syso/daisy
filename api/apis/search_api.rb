class SearchAPI < ApplicationAPI

  helpers do
    def search_resource klass
      { 
        hospital: Hospitals::Hospital,
        doctor: Hospitals::Doctor,
        symptom: Symptoms::Symptom,
        disease: Diseases::Disease,
        drug: Drugs::Drug,
        manufactory: Drugs::Manufactory
      }[klass.to_sym]
    end
  end

  namespace :search do
    params do
      requires :label, type: String, desc: '类别'
      optional :city, type: String, desc: '上海'
      optional :province, type: String, desc: '松江'
      optional :query, type: String, desc: '张三'
    end
    get do
      query = if params.label == 'doctor'
        {
          query: {
            bool: {
              should:[
                {
                  more_like_this: {
                    fields: ["name", "hospital_name", "name_initials"],
                    like_text: params.query,
                    min_term_freq: 1,
                    max_query_terms: 12
                  }
                },
                {
                  match: {
                    name: params.query
                  }
                }
              ]
            }
          }
        }
      else
        {
          query: {
            bool: {
              should:[
                {
                  match_phrase_prefix: {
                    name_initials: query
                  }
                },
                {
                  match_phrase_prefix: {
                    name: query
                  }
                }
              ]
            }
          }
        }
      end

      data = search_resource(params.label).search(query)
      data = data.records
      present! data, with: PolymorphicEntity, meta: { title: "搜索结果", fin: false }
    end
  end

  namespace :search_index do
    # get do
    #   has_scope :query
    #   data = apply_scopes! search_resource(params[:label])
    #   data = data.page(params[:per] || 1).records
    #   present! data, with: PolymorphicEntity, meta: { title: "搜索结果", fin: false }
    # end
    params do
      requires :label, type: String, desc: '类别'
      optional :city, type: String, desc: '上海'
      optional :province, type: String, desc: '松江'
      optional :query, type: String, desc: '张三'
    end
    get do
      query = if params.label == 'doctor'
        {
          query: {
            bool: {
              should:[
                {
                  more_like_this: {
                    fields: ["name", "hospital_name", "name_initials"],
                    like_text: params.query,
                    min_term_freq: 1,
                    max_query_terms: 12
                  }
                },
                {
                  match: {
                    name: params.query
                  }
                }
              ]
            }
          }
        }
      else
        {
          query: {
            bool: {
              should:[
                {
                  match_phrase_prefix: {
                    name_initials: query
                  }
                },
                {
                  match_phrase_prefix: {
                    name: query
                  }
                }
              ]
            }
          }
        }
      end

      data = search_resource(params.label).search(query)
      data = data.records
      present! data, with: PolymorphicEntity, meta: { title: "搜索结果", fin: false }
    end
  end

end