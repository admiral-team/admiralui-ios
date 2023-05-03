# frozen_string_literal: true

require_relative '../../figma_client/figma_client'

class StylesTemplate
  attr_accessor :groups, :styles, :common_style_names

  def initialize(styles:)
    styles = styles.sort_by(&:name)
    @styles = styles

    groups_hash = {}

    styles.each do |s|
      group = groups_hash[s.name_info.group_name] || StylesGroup.new(name: s.name_info.group_name, styles: [])
      group.styles.push(s)
      groups_hash[s.name_info.group_name] = group
    end

    @groups = groups_hash.map { |_key, value| value }

    @common_style_names = styles
                          .uniq { |s| s.name_info.style_name }
                          .map { |s| s.name_info.style_name }
  end

  def to_hash
    hash = {}
    hash['styles'] = styles.map(&:to_hash)
    hash['groups'] = groups.map(&:to_hash)
    hash['common_style_names'] = common_style_names
    hash
  end
end
