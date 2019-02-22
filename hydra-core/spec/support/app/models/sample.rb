# frozen_string_literal: true

class Sample
  # This is a stub model for testing.

  cattr_accessor :objects
  self.objects = {}

  def self.create(_params = {})
    obj = Sample.new
    obj.save
    obj
  end

  def save
    @pid ||= "sample:#{(rand * 1000).to_i}"
    self.class.objects[@pid] = self
  end

  def update_attributes(attributes)
    attributes.each do |k, v|
      instance_variable_set "@#{k}".to_sym, v

      self.class.send :attr_accessor, k
    end
  end

  def self.find(pid)
    objects[pid]
  end

  attr_reader :pid
end
