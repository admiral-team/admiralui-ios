# frozen_string_literal: true

class Hash
  def dig_set(keys, value, force = false, delete_if_nil = true)
    final_key = keys.pop
    position = self
    keys.each do |key|
      position[key] = {} if !position[key].is_a?(Hash) && force
      position = position[key]
      break if position.nil?
    end
    if delete_if_nil && value.nil?
      position&.delete(final_key)
    else
      position[final_key] = value
    end
  end
end
