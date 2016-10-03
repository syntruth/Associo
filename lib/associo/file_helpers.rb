module Associo
  # Syntax helper for accessing file attributes.
  module FileHelpers
    def self.name(file)
      return file.original_filename if file.respond_to?(:original_filename)

      File.basename(file.path)
    end

    def self.size(file)
      file.respond_to?(:size) ? file.size : File.size(file)
    end

    def self.type(file)
      return file.type if file.is_a? Associo::IO

      Wand.wave file.path, original_filename: Associo::FileHelpers.name(file)
    end
  end
end
