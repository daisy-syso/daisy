module ResourcesHelper

  def index! klass, options = {}

    filters = options[:filters] || []

    params do
      filters.each do |filter, options|
        options = options.slice(:type, :default)
        optional filter, options.reverse_merge(type: Integer)
      end
    end
    get do
      meta = options[:meta] || {}
      meta[:title] ||= options[:title]
      meta[:filters] = [] if filters.any?

      filters.each do |filter, options|
        children_proc = options[:children] || proc do
          options[:class].filters
        end
        children = children_proc.call

        current_proc = options[:current] || proc do |id|
          id ? options[:class].find(id).name : "全部"
        end
        current = current_proc.call params[filter]

        meta[:filters].push title: options[:title], 
          children: children, current: current
      end

      filters.each do |filter, options|
        options = options.slice(:type, :using)
        options[:type] = options[:type].name.downcase.to_sym if options[:type]
        has_scope filter, options
      end

      if options[:parent]
        data = options[:parent].call(params)
      else
        data = klass.all
        includes = options[:includes]
        data = data.includes(includes) if includes
        scopes = Array.wrap(options[:scopes])
        scopes.each do |scope|
          data = data.send(scope)
        end if scopes.any?
      end
      data = apply_scopes!(data)

      opts = options.slice(:with)
      opts[:meta] = meta
      present! data, opts
    end

  end

  def show! klass, options = {}
    
    params do
      requires :id, type: Integer
    end
    get ":id" do
      present! klass.find(params[:id]), detail: true
    end
  end
  
end
