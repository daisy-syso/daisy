module ResourcesHelper

  def resources path, options = {}

    klass = options[:class]
    filters = options[:filters] || []

    params do
      filters.each do |filter, options|
        options = options.slice(:type, :default)
        optional filter, options.reverse_merge(type: Integer)
      end
    end
    get path do

      meta = options[:meta] || {}
      meta[:title] ||= options[:title]
      meta[:filters] = [] if filters.any?

      filters.each do |filter, options|
        has_scope filter
        children = options[:class].filters_with_cache
        current = params[filter] ? options[:class].find(params[filter]).name : "全部"
        meta[:filters].push title: options[:title], children: children, current: current
      end

      includes = options[:includes]
      data = klass.all
      data = data.includes(includes) if includes
      data = apply_scopes!(data)
      present! data, meta: meta
    end

    params do
      requires :id, type: Integer
    end
    get "#{path.to_s.singularize}/:id" do
      present! klass.find(params[:id])
    end

  end

end
