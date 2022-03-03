require 'json'

# Version managment

def current_lib_external_version
  params = JSON.parse(File.read(ENV['VERSION_FILE']))
  params["external_version"]
end

def current_lib_internal_version
  params = JSON.parse(File.read(ENV['VERSION_FILE']))
  params["internal_version"]
end

def current_lib_version
  "iOS #{current_lib_external_version}"
end

def unreleased_version
  "iOS UNRELEASED (#{current_lib_internal_version})"
end

def current_lib_full_version
  version_name = current_lib_external_version + " (" + current_lib_internal_version + ")"
  version_name
end

def last_version_tag
  system('git describe --tags `git rev-list --tags --max-count=1`')
end

def increment_podspec_version(path:, version:)
  content = File.read(path)
  content = content.gsub(/spec.version      = \"(.*?)\"/, "spec.version      = \"#{version}\"")
  File.open(path, 'w') { |file| file.write(content) }
end
  
def set_version(external_version:, internal_version:)
  file_name = ENV['VERSION_FILE']
  params = JSON.parse(File.read(file_name))
  params['internal_version'] = internal_version if !internal_version.nil?
  params['external_version'] = external_version if !external_version.nil?

  File.open(file_name, "w") {|f| f.write(JSON.pretty_generate(params)) }
end