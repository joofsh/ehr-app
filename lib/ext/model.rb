class Sequel::Model
  def self.hidden_fields *fields
    @hidden_fields ||= [*fields]
  end

  def self.presented_methods *fields
    @presented_methods ||= [*fields]
  end

  def self.blacklisted_fields *fields
    @blacklisted_fields ||= [*fields, :id, :created_at, :updated_at]
  end

  def self.whitelist! attrs
    attrs.keep_if { |key, _| !blacklisted_fields.include?(key.to_sym) }
  end

  def present params = {}
    obj = self.to_hash


    _hidden_fields.each do |field|
      obj.delete(field)
    end

    _presented_methods.each do |method|
      obj[method] = self.send(method) rescue nil
    end

    obj
  end

  private

  def _presented_methods
    self.class.presented_methods + self.class.superclass.presented_methods
  end

  def _hidden_fields
    self.class.hidden_fields + self.class.superclass.hidden_fields
  end
end
