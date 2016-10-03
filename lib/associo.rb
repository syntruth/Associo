require 'set'
require 'mime/types'
require 'wand'
require 'active_support/concern'

# Main Associo module
module Associo
  extend ActiveSupport::Concern

  included do
    class_attribute :attachment_names

    self.attachment_names = Set.new

    include attachment_accessor_module
  end

  def self.blank?(str)
    str.nil? || str !~ /\S/
  end

  private_class_method :blank?
end

require 'associo/class_methods'
require 'associo/instance_methods'
require 'associo/attachment_proxy'
require 'associo/io'
require 'associo/file_helpers'
