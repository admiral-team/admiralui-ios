# NexusInfo managment

class ReleaseAsset
    attr_accessor :name
    attr_accessor :label
    attr_accessor :media_type
    attr_accessor :path
  end
    
  def formatted_release_asset_json(release_asset:)
    str = '{'
    str += '\"Name\"' + ':"\"' + "#{release_asset.name}" + '"\"' + '","' unless release_asset.name.nil?
    str += '\"Label\"' + ':"\"' + "#{release_asset.label}" + '"\"' + '","' unless release_asset.label.nil?
    str += '\"MediaType\"' + ':"\"' + "#{release_asset.media_type}" + '"\"' + '","' unless release_asset.media_type.nil?
    str += '\"Path\"' + ':"\"' + "#{release_asset.path}" + '"\"' unless release_asset.path.nil?
    str += '}'
    str
  end
