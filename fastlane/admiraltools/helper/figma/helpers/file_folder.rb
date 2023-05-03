# frozen_string_literal: true

require 'fileutils'

class File
  def self.open_file(file_name:, mode:, create_directories:)
    create_directories = !create_directories.nil? || false
    if create_directories
      dirname = File.dirname(file_name)
      FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
    end
    File.open(file_name, mode)
  end

  def self.read_file_json(path:)
    if File.exist?(path)
      text = File.read(path)
      JSON.parse(text)
    else
      nil
    end
  end

  def self.write_file_json(hash:, path:, create_directories: true)
    file = File.open_file(file_name: path, mode: 'w', create_directories: create_directories)
    json = JSON.pretty_generate(hash)
    file.write(json)
    file.close
  end
end
