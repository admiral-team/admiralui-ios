# frozen_string_literal: true

class String
  FORMAT_STYLE_CAMELCASE = 'camelcase'
  FORMAT_STYLE_SNAKECASE = 'snakecase'
  FORMAT_STYLE_KEBABCASE = 'kebabcase'

  def uppercase_first_letter
    capitalize
  end

  def lowercase_first_letter
    return self unless length.positive?

    self[0, 1].downcase + self[1..-1]
  end

  def snakecase
    gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .gsub(/\s/, '_')
      .gsub(/__+/, '_')
      .downcase
  end

  def kebabcase
    snakecase.gsub(/_/, '-')
  end

  def camelcase(*separators)
    case separators.first
    when Symbol, TrueClass, FalseClass, NilClass
      first_letter = separators.shift
    end

    separators = ['_', '\s'] if separators.empty?

    str = dup

    separators.each do |s|
      str = str.gsub(/(?:#{s}+)([a-zA-Z0-9])/) { Regexp.last_match(1).upcase }
    end

    case first_letter
    when :upper, true
      str = str.gsub(/(\A|\s)([a-z])/) { Regexp.last_match(1) + Regexp.last_match(2).upcase }
    when :lower, false
      str = str.gsub(/(\A|\s)([A-Z])/) { Regexp.last_match(1) + Regexp.last_match(2).downcase }
    end

    str
  end

  def default_format
    available_symbols_regex = /[^a-zA-Z0-9_]/
    separator_symbols = [' ', '_', '-', '/']
    camelcase(separator_symbols).gsub(available_symbols_regex, '').lowercase_first_letter
  end
end
