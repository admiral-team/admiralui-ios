# frozen_string_literal: true

class ScaleFormatter
  def scales_from_dpis(dpis)
    return [] if dpis.nil?

    dpis.map { |d| scale_from_dpi(d) }.compact
  end

  def dpis_from_scales(scales)
    return [] if scales.nil?

    scales.map { |s| dpi_from_scale(s) }.compact
  end

  def any_scales_to_scales(scales)
    return [] if scales.nil?

    result_scales = []
    scales.each do |scale|
      case scale
      when String
        converted_scale = scale_from_dpi(scale)
        if !converted_scale.nil?
          result_scales.push(converted_scale)
        else
          float_scale = scale.to_f
          result_scales.push(float_scale) unless float_scale.nil?
        end
      when Numeric
        result_scales.push(scale)
      else
        next
      end
    end
    result_scales.uniq
  end

  def scale_from_dpi(dpi)
    dpi = dpi.downcase
    case dpi
    when 'ldpi'
      0.75
    when 'mdpi'
      1.0
    when 'hdpi'
      1.5
    when 'xhdpi'
      2.0
    when 'xxhdpi'
      3.0
    when 'xxxhdpi'
      4.0
    else
      nil
    end
  end

  def dpi_from_scale(scale)
    scale = scale.round(2)
    case scale
    when 0.75
      'ldpi'
    when 1.0
      'mdpi'
    when 1.5
      'hdpi'
    when 2.0
      'xhdpi'
    when 3.0
      'xxhdpi'
    when 4.0
      'xxxhdpi'
    else
      nil
    end
  end

  def formatted_scale(scale:, convert_to_dpi: false)
    return nil if scale.nil?

    dpi_scale = dpi_from_scale(scale)

    if convert_to_dpi && !dpi_scale.nil?
      dpi_scale
    else
      "#{scale.to_s_formatted.gsub(/[.,]/, '_')}x"
    end
  end
end

class Numeric
  def to_s_formatted
    to_s.chomp('.0')
  end
end
