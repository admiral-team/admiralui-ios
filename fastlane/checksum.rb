require 'json'

# Checksum managment

def admiral_swiftui_checksum
  params = JSON.parse(File.read(ENV['CHECKSUM_FILE']))
  params["AdmiralSwiftUI"]
end

def admiral_theme_checksum
  params = JSON.parse(File.read(ENV['CHECKSUM_FILE']))
  params["AdmiralTheme"]
end

def admiral_resources_checksum
  params = JSON.parse(File.read(ENV['CHECKSUM_FILE']))
  params["AdmiralUIResources"]
end

def admiral_uikit_checksum
  params = JSON.parse(File.read(ENV['CHECKSUM_FILE']))
  params["AdmiralUIKit"]
end

def admiral_core_checksum
  params = JSON.parse(File.read(ENV['CHECKSUM_FILE']))
  params["AdmiralCore"]
end
  
def set_checksum(admiral_swiftui_checksum:, admiral_theme_checksum:, admiral_resources_checksum:, admiral_uikit_checksum:, admiral_core_checksum:)
  file_name = ENV['CHECKSUM_FILE']
  params = JSON.parse(File.read(file_name))
  params['AdmiralSwiftUI'] = admiral_swiftui_checksum if !admiral_swiftui_checksum.nil?
  params['AdmiralTheme'] = admiral_theme_checksum if !admiral_theme_checksum.nil?
  params['AdmiralUIResources'] = admiral_resources_checksum if !admiral_resources_checksum.nil?
  params['AdmiralUIKit'] = admiral_uikit_checksum if !admiral_uikit_checksum.nil?
  params['AdmiralCore'] = admiral_core_checksum if !admiral_core_checksum.nil?

  File.open(file_name, "w") {|f| f.write(JSON.pretty_generate(params)) }
end
