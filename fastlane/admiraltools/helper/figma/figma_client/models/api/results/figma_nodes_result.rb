# frozen_string_literal: true

require_relative '../primitives/figma_node'

class FigmaNodesResult
  attr_accessor :name, :nodes

  def initialize(name:, nodes:)
    @name = name
    @nodes = nodes
  end

  def self.from_hash(hash)
    return nil if hash.nil?

    name = hash['name']
    nodes = FigmaNodesResult.parse_nodes(hash: hash['nodes'])

    return FigmaNodesResult.new(name: name, nodes: nodes) if !name.nil? && !nodes.nil?

    nil
  end

  def to_hash
    hash = {}
    hash['name'] = name
    nodes_hash = (nodes || {})
    nodes_result_hash = {}

    nodes_hash.each do |k, v|
      node = v['document'].to_hash
      nodes_result_hash[k] = { 'document' => node } unless node.nil?
    end

    hash['nodes'] = nodes_result_hash
    hash
  end

  def self.parse_nodes(hash:)
    return nil if hash.nil?

    result_hash = {}

    hash.each do |k, v|
      node_hash = v['document']
      node = FigmaNode.from_hash(node_hash)
      result_hash[k] = { 'document' => node } unless node.nil?
    end

    result_hash
  end
end
