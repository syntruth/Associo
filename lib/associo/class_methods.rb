module Associo
  # Define new class methods for documents that
  # include the Associo module.
  module ClassMethods
    DEFAULT_CHUNK_SIZE = 261_120

    def attachment_accessor_module
      @attachment_accessor_module ||= Module.new
    end

    # rubocop:disable AbcSize, MethodLength
    # TODO: refactor this.
    def attachment(name, options = {})
      options.symbolize_keys!

      name = name.to_sym

      chunk_size = options.fetch(:chunk_size, DEFAULT_CHUNK_SIZE).to_i
      chunk_size = DEFAULT_CHUNK_SIZE if chunk_size.zero?

      self.attachment_names = attachment_names.dup.add(name)

      after_save     :save_attachments
      before_save    :nullify_nil_attachments_attributes
      after_save     :destroy_nil_attachments
      before_destroy :destroy_all_attachments

      key :"#{name}_id",   ObjectId
      key :"#{name}_name", String
      key :"#{name}_size", Integer
      key :"#{name}_type", String

      # Allow for optional, custom chunk size, in bytes.
      # Default size is 255k, set above.
      key :"#{name}_chunk_size", Integer, default: chunk_size

      validates_presence_of(name) if options[:required]

      attachment_accessor_module.module_eval <<-EOC
        def #{name}
          @#{name} ||= AttachmentProxy.new(self, :#{name})
        end

        def #{name}?
          !nil_attachments.has_key?(:#{name}) && send(:#{name}_id?)
        end

        def #{name}=(file)
          if file.nil?
            nil_attachments[:#{name}] = send("#{name}_id")
            assigned_attachments.delete(:#{name})
          else
            send("#{name}_id=", BSON::ObjectId.new) if send("#{name}_id").nil?
            send("#{name}_name=", Associo::FileHelpers.name(file))
            send("#{name}_size=", Associo::FileHelpers.size(file))
            send("#{name}_type=", Associo::FileHelpers.type(file))
            assigned_attachments[:#{name}] = file
            nil_attachments.delete(:#{name})
          end
        end
      EOC
    end
  end
end
