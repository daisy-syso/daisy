module ResourcesHelper
  extend ActiveSupport::Concern

  module ClassMethods
    TYPES = {
      Array   => :array,
      Hash    => :hash,
      Object  => :boolean
    }

    def index! klass, options = {}
      filters = options[:filters] || {}

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
        meta = options[:meta] ? options[:meta].dup : {}
        meta[:title] ||= parse_option_value options[:title]
        meta[:related] ||= parse_option_value options[:related]
        meta[:recommend] ||= parse_option_value options[:recommend]
        meta[:template] ||= parse_option_value options[:template]
        klass = parse_option_value options[:klass] if (parse_option_value options[:klass]).present?
        hfilters = {}

        parse_option_value options[:before]

        filters.each do |key, options|
          next if options[:scope_only]

          filter = generate_filter key, options

          if options[:titleize]
            meta[:subtitle] = filter
          elsif options[:append]
            hfilters[options[:append]][:children] ||= []
            hfilters[options[:append]][:children].push filter
          else
            hfilters[key] = filter
          end
        end
        meta[:filters] = hfilters.values if hfilters.any?

        filters.each do |filter, options|
          next if options[:filter_only]
          
          soptions = options.slice(:using)
          if options[:type]
            soptions[:type] = TYPES[options[:type]] || :default
          end

          if options[:has_scope]
            has_scope filter, soptions, &options[:has_scope]
          else
            has_scope filter, soptions
          end
        end

        data = parse_option_value options[:parent] do
          if options[:includes]
            klass.includes(options[:includes])
          else
            klass.all
          end
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

    def filter! klass, options = {}
      get :filters do
        present(klass.filters)
      end
    end

  end
end
