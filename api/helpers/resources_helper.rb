module ResourcesHelper

  TYPES = {
    Array   => :array,
    Hash    => :hash,
    Object  => :boolean
  }

  def index! klass, options = {}

    filters = options[:filters] || []

    params do
      filters.each do |name, options|
        options = options.slice(:type, :default)
        optional name, options.reverse_merge(type: Integer)
      end
      options[:params].to_a.each do |name, options|
        optional name, options.reverse_merge(type: Integer)
      end
    end
    get do
      meta = options[:meta] || {}
      meta[:title] ||= options[:title]
      meta[:filters] = [] if filters.any?

      if options[:before]
        instance_exec &options[:before]
      end

      filters.each do |name, options|
        filter = options[:meta] || {}

        children_proc = options[:children] || proc do
          options[:class].filters
        end
        filter[:children] = instance_exec &children_proc

        current_proc = options[:current] || proc do |id|
          id ? options[:class].find(id).name : options[:title]
        end
        filter[:current] = instance_exec params[name], &current_proc

        if options[:titleize]
          meta[:subtitle] = filter
        else
          meta[:filters].push filter
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
