module ResourcesHelper

  TYPES = {
    Array   => :array,
    Hash    => :hash,
    Object  => :boolean
  }

  def index! klass, options = {}

    filters = options[:filters] || []

    params do
      filters.each do |filter, options|
        options = options.slice(:type, :default)
        optional filter, options.reverse_merge(type: Integer)
      end
      options[:params].to_a.each do |filter, options|
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
        children = instance_exec &children_proc

        current_proc = options[:current] || proc do |id|
          id ? options[:class].find(id).name : options[:title]
        end
        current = instance_exec params[filter], &current_proc

        meta[:filters].push children: children, current: current

        if options[:titleize]
          meta[:subtitle] = meta[:title]
          meta[:title] = current
        end
      end

      filters.each do |filter, options|
        has_scope_proc = options[:has_scope]
        options = options.slice(:type, :using)
        options[:type] = TYPES[options[:type]] || :default if options[:type]
        if has_scope_proc
          has_scope filter, options, &has_scope_proc
        else
          has_scope filter, options
        end
      end

      if options[:parent]
        data = instance_exec &options[:parent]
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
