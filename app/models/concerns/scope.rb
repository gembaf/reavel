
module Scope
  def active(base)
    base.class_eval do
      scope :active, -> { where(is_active: true) }
    end
  end

  def serial_by(base)
    base.class_eval do
      scope :serial_by, -> { order("episode") }
    end
  end

  def updated_by(base)
    base.class_eval do
      scope :updated_by, -> { order("updated_at DESC") }
    end
  end

  def active_by(base)
    base.class_eval do
      scope :active_by, -> { order("is_active DESC") }
    end
  end

  module_function :active, :serial_by, :updated_by, :active_by
end

