# frozen_string_literal: true

class StyleNameInfo
  attr_accessor :full_name, :group_name, :style_name

  def initialize(
    full_name:,
    group_name:,
    style_name:
  )
    @full_name = full_name
    @group_name = group_name
    @style_name = style_name
  end

  def self.create_from(name:)
    name ||= ''
    full_name = name
    name_array = name.split('/')

    if name_array.count > 1
      group_name = name_array[0]
      name_array.shift
      style_name = name_array.join('/')
    else
      group_name = 'Default'
      style_name = name_array[0] || 'unknown'
    end

    StyleNameInfo.new(
      full_name: full_name,
      group_name: group_name,
      style_name: style_name
    )
  end

  def to_hash
    hash = {}
    hash['full_name'] = full_name
    hash['group_name'] = group_name
    hash['style_name'] = style_name
    hash
  end
end

class Style
  attr_accessor :name, :node_id, :style_type, :description, :color, :font

  def description_params
    JSON.parse(description)
  rescue StandardError
    nil
  end

  def initialize(
    name:,
    node_id:,
    style_type:,
    description:,
    color: nil,
    font: nil
  )
    @name = name
    @node_id = node_id
    @style_type = style_type
    @description = description
    @color = color
    @font = font
  end

  def name_info
    StyleNameInfo.create_from(name: name)
  end

  def is_dark
    name.downcase.include?('dark') || false
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    name = hash['name']
    node_id = hash['node_id']
    style_type = hash['style_type']
    description = hash['description']
    color_hash = hash['color']
    font_hash = hash['font']

    color = !color_hash.nil? ? Color.from_hash(color_hash) : nil
    font = !font_hash.nil? ? Font.from_hash(font_hash) : nil

    if !name.nil? && !node_id.nil? && style_type
      return Style.new(name: name, node_id: node_id, style_type: style_type, description: description,
                       color: color, font: font)
    end

    nil
  end

  def to_hash
    hash = {}
    hash['name'] = name
    hash['node_id'] = node_id
    hash['style_type'] = style_type
    hash['description'] = description
    hash['color'] = color&.to_hash unless color.nil?
    hash['font'] = font&.to_hash unless font.nil?
    hash['name_info'] = name_info.to_hash unless name_info.nil?
    hash['description_params'] = description_params unless description_params.nil?
    hash['is_dark'] = is_dark
    hash
  end
end
