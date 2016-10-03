module Associo
  # Proxy for the Attached file.
  class AttachmentProxy
    def initialize(instance, name)
      @instance = instance
      @name     = name
    end

    def id
      @instance.send "#{@name}_id"
    end

    def name
      @instance.send "#{@name}_name"
    end

    def size
      @instance.send "#{@name}_size"
    end

    def type
      @instance.send "#{@name}_type"
    end

    def chunk_size
      @instance.send "#{@name}_chunk_size"
    end

    def nil?
      !@instance.send("#{@name}?")
    end

    alias blank? nil?

    def grid_io
      @grid_io ||= @instance.grid.get(id)
    end

    def method_missing(method, *args, &block)
      if grid_io.respond_to? method.to_s
        grid_io.send(method, *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      super
    end
  end
end
