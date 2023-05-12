# frozen_string_literal: true

require_relative 'string_format'

module StringFilters
  # Letter case

  def uppercase_first_letter(input)
    input.uppercase_first_letter
  end

  def lowercase_first_letter(input)
    input.lowercase_first_letter
  end

  # Snake case

  def snakecase(input)
    input.snakecase
  end

  def upper_snakecase(input)
    input.snakecase.uppercase_first_letter
  end

  def lower_snakecase(input)
    input.snakecase.lowercase_first_letter
  end

  # Kebab case

  def kebabcase(input)
    input.kebabcase
  end

  def upper_kebabcase(input)
    input.kebabcase.uppercase_first_letter
  end

  def lower_kebabcase(input)
    input.kebabcase.lowercase_first_letter
  end

  # Camel case

  def camelcase_s(input, *separators)
    input.camelcase(separators)
  end

  def upper_camelcase(input, *separators)
    input.camelcase(separators)
  end

  def lower_camelcase(input, *separators)
    input.camelcase(separators)
  end

  # Formatting

  def default_format(input)
    input.default_format
  end
end
