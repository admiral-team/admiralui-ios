# NexusInfo managment

class NexusInfo
    attr_accessor :repository
    attr_accessor :group_id
    attr_accessor :artifact_id
    attr_accessor :version
    attr_accessor :ziped_framework_path
    attr_accessor :extension
    attr_accessor :nexus_url
    attr_accessor :username  
    attr_accessor :password  
  end
    
  def formatted_nexus_info_json(nexus_info:)
    str = '{'
    str += '\"Repository\"' + ':"\"' + "#{nexus_info.repository}" + '"\"' + '","' unless nexus_info.repository.nil?
    str += '\"GroupId\"' + ':"\"' + "#{nexus_info.group_id}" + '"\"' + '","' unless nexus_info.group_id.nil?
    str += '\"ArtifactId\"' + ':"\"' + "#{nexus_info.artifact_id}" + '"\"' + '","' unless nexus_info.artifact_id.nil?
    str += '\"Version\"' + ':"\"' + "#{nexus_info.version}" + '"\"' + '","' unless nexus_info.version.nil?
    str += '\"ZipedFrameworkPath\"' + ':"\"' + "#{nexus_info.ziped_framework_path}" + '"\"' + '","' unless nexus_info.ziped_framework_path.nil?
    str += '\"Extension\"' + ':"\"' + "#{nexus_info.extension}" + '"\"' + '","' unless nexus_info.extension.nil?
    str += '\"NexusUrl\"' + ':"\"' + "#{nexus_info.nexus_url}" + '"\"' + '","' unless nexus_info.nexus_url.nil?
    str += '\"Username\"' + ':"\"' + "#{nexus_info.username}" + '"\"' + '","' unless nexus_info.username.nil?
    str += '\"Password\"' + ':"\"' + "#{nexus_info.password}" + '"\"' unless nexus_info.password.nil?
    str += '}'
    str
  end