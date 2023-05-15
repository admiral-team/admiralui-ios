# frozen_string_literal: true

class SvtToVectorConverter
  def convert(input_file:, output_file: nil)
    return unless ['.svg'].include?(File.extname(input_file))

    name = File.join(File.dirname(input_file), File.basename(input_file, File.extname(input_file)))
    output_file = output_file.nil? ? "#{name}.xml" : output_file
    jar_file = File.join(File.dirname(__FILE__), '../bin/svg2vectordrawable.jar')
    system("java -jar #{jar_file} #{input_file} #{output_file} true")
  end
end
