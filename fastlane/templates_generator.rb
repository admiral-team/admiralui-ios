class FullNameTemplateGenerator
    def generate(
        list:,
        start_block:,
        end_block:,
        data_block:,
        offset: "")
        data = prepare(list: list)
        return generate_string(data: data, start_block: start_block, end_block: end_block, data_block: data_block, offset: offset)
    end

    private def generate_string(
        data:,
        start_block:,
        end_block:,
        data_block:,
        offset: "", 
        string: "")
        if data.instance_of?(Array)
            sorted = data.sort_by { |k| k['name'] }
            sorted.each do |d|
                string += "#{offset}#{data_block.call(d['name'],d['full_name'])}"
            end
            return string
        end
    
        if data.instance_of?(Hash)
            keys = data.keys.sort.reverse
            keys.each do |k|
                string += "#{offset}#{start_block.call(k)}"
                string = generate_string(
                    data: data[k], 
                    start_block: start_block, 
                    end_block: end_block, 
                    data_block: data_block, 
                    offset: offset + "    ", 
                    string: string
                )
                string += "#{offset}#{end_block.call(k)}"
            end
        end
    
        return string
    end
        
    private def prepare(list:)
        result = {}
        list.each do |e|
            current_hash = result
            components = e.split("/")
            components.each_with_index do |c, i|
                if i == components.length - 2
                    new_value = { "name" => components[i+1], "full_name" => e }
                    current_hash[c] = current_hash[c] || []
                    current_hash[c].append(new_value)
                    break
                end
                current_hash[c] = current_hash[c] || {}
                current_hash = current_hash[c]
            end
        end
        return result
    end

end

require 'find'

def find_files(path:, extension:)
    paths = []
    Find.find(path) do |p|
        paths << p if p =~ Regexp.new(".*\.#{extension}$")
    end
    return paths
end

def find_resources(path:, extension:)
    result = find_files(path: path, extension: extension)
    result = result.map do |s| 
        s.gsub!(Regexp.new(path), '')
        s.gsub!(Regexp.new(".#{extension}"), '')
        s.delete_prefix!('/')
    end
    return result
end

def generate_swiftui_symbols(list:, enum_name:, image_type_name:, file:)
    result = FullNameTemplateGenerator.new().generate(
        list: list,
        start_block: Proc.new { |k| "public enum #{k} {\n" },
        end_block: Proc.new { |k|  "}\n" },
        data_block: Proc.new { |n, f| "public static let `#{n}` = #{image_type_name}(name: \"#{f}\")\n" },
        offset: "   "
    )

    body = """
// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// MARK: - Asset Catalogs

@available(iOS 14.0, *)
public enum #{enum_name} {
#{result}}

// MARK: - Implementation Details

@available(iOS 14.0, *)
public struct #{image_type_name} {
public fileprivate(set) var name: String
    public var image: Image {
        return Image(name, bundle: BundleToken.bundle)
    }
}

private final class BundleToken {
static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
}()
}
// swiftlint:enable all
"""
    File.open(file, 'w') { |f| f.write(body) }
end