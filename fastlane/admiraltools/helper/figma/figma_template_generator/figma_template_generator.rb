# frozen_string_literal: true

require_relative 'models/styles_template'

class FigmaTemplateGenerator
  def generate(styles:, style_types:, template_path:, output_path:)
    require 'liquid'
    Liquid::Template.register_filter(StringFilters)

    styles = styles.select { |s| (style_types.nil? || style_types.include?(s.style_type)) }
    template_data = StylesTemplate.new(styles: styles).to_hash

    dir_name = File.dirname(output_path)
    FileUtils.mkdir_p(dir_name) unless File.directory?(dir_name)

    template = File.read(template_path)
    output = Liquid::Template.parse(template).render(template_data)
    output_file = File.open(output_path, 'w')
    output_file.write(output)
    output_file.close unless output.nil?
  end
end
