# frozen_string_literal: true

require_relative '../primitives/figma_components_styles_meta'

class FigmaComponentsStylesResult
  attr_accessor :error, :status, :meta

  def initialize(error:, status:, meta:)
    @error = error
    @status = status
    @meta = meta
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    error = hash['error']
    status = hash['status']
    meta_hash = hash['meta']
    meta = meta_hash.nil? ? nil : FigmaComponentsStylesMeta.from_hash(meta_hash)

    if !error.nil? && !status.nil? && !meta.nil?
      return FigmaComponentsStylesResult.new(error: error, status: status, meta: meta)
    end

    nil
  end

  def to_hash
    hash = {}
    hash['error'] = error
    hash['status'] = status
    hash['meta'] = meta.to_hash unless meta.nil?
    hash
  end
end
