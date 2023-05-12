# frozen_string_literal: true

require_relative '../../models'

class FigmaToDomainConverter
  def convert_figma_style(figma_style:)
    return nil if figma_style.nil?

    Style.new(
      name: figma_style.name,
      node_id: figma_style.node_id,
      style_type: figma_style.style_type,
      description: figma_style.description
    )
  end

  def fulfill_styles(figma_nodes_result:, figma_styles_result:)
    return [] if figma_nodes_result.nil? || figma_styles_result.nil?

    styles = []
    figma_styles = figma_styles_result&.meta&.styles || []
    nodes = figma_nodes_result&.nodes || {}

    figma_styles.each do |s|
      style = convert_figma_style(figma_style: s)
      node = nodes.dig(s.node_id, 'document')

      case s.style_type
      when FIGMA_STYLE_TYPE_FILL
        fills = node&.fills
        next if fills.nil?

        figma_paint = fills[0]
        next if figma_paint.nil?

        style&.color = Color.new(
          r: figma_paint.color.r,
          g: figma_paint.color.g,
          b: figma_paint.color.b,
          a: figma_paint.opacity
        )
        styles.push(style)
      when FIGMA_STYLE_TYPE_TEXT
        type_style = node&.style
        next if type_style.nil?

        style&.font = Font.new(
          font_family: type_style.font_family,
          font_postscript_name: type_style.font_postscript_name,
          font_size: type_style.font_size,
          font_weight: type_style.font_weight,
          letter_spacing: type_style.letter_spacing
        )
        styles.push(style)
      else
        next
      end
    end

    styles
  end

  def fulfill_components(figma_components:, image_links_hash:, image_format:)
    return [] if figma_components.nil? || image_links_hash.nil?

    components = []
    figma_components.each do |c|
      component = Component.new(
        key: c.key,
        file_key: c.file_key,
        node_id: c.node_id,
        name: c.name,
        description: c.description
      )

      component.containing_frame = FrameInfo.new(
        node_id: c.containing_frame.node_id,
        name: c.containing_frame.name,
        background_color: c.containing_frame.background_color,
        page_id: c.containing_frame.page_id,
        page_name: c.containing_frame.page_name
      )

      image_links = []
      image_links_hash.each do |key, link_hash|
        link = link_hash[c.node_id]
        if !link.nil? && !key.nil? && !image_format.nil?
          image_link = ImageLink.new(link: link, scale: key, image_format: image_format)
          image_links.push(image_link)
        end
      end
      component.image_links = image_links
      components.push(component)
    end

    components
  end
end
