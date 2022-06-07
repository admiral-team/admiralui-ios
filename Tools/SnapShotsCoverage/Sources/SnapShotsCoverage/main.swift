import ArgumentParser
import SourceKittenFramework
import Foundation

struct CommandLineParser: ParsableCommand {

    // MARK: - Constants

    private enum Constants {
        static let allowedFileExtension = "swift"
    }

    // MARK: - Plain Model

    struct FileInfo {
        enum Accesibility {
            case `public`
            case `open`
            case other
            init(with string: String) {
                switch string {
                case "source.lang.swift.accessibility.public":
                    self = .public
                case "source.lang.swift.accessibility.open":
                    self = .open
                default:
                    self = .other
                }
            }
        }

        enum ObjectType {
            case `class`
            case `struct`
            case other
            init(with string: String) {
                switch string {
                case "source.lang.swift.decl.struct":
                    self = .struct
                case "source.lang.swift.decl.class":
                    self = .class
                default:
                    self = .other
                }
            }
        }

        // MARK: - Properties

        let name: String
        let accesibility: Accesibility
        let kind: ObjectType
        let fileUrl: String
        let isTestIncluded: Bool

        // MARK: - Initializer

        init(
            name: String?,
            accesibility: String?,
            kind: String?,
            fileUrl: String,
            isTestIncluded: Bool = false
        ) {
            self.name = name ?? ""
            self.accesibility = Accesibility(with: accesibility ?? "")
            self.kind = ObjectType(with: kind ?? "")
            self.fileUrl = fileUrl
            self.isTestIncluded = isTestIncluded
        }
    }

    // MARK: - DTO Source File Model

    struct SyntaxStructureDTO: Decodable {
        let accessibility: String?
        let attribute: String?
        let attributes: [SyntaxStructureDTO]?
        let bodylength: Int?
        let bodyoffset: Int?
        let diagnosticstage: String?
        let elements: [SyntaxStructureDTO]?
        let inheritedTypes: [SyntaxStructureDTO]?
        let kind: String?
        let length: Int?
        let name: String?
        let namelength: Int?
        let nameoffset: Int?
        let offset: Int?
        let runtimename: String?
        let substructure: [SyntaxStructureDTO]?
        let typename: String?

        enum CodingKeys: String, CodingKey {
            case accessibility = "key.accessibility"
            case attribute = "key.attribute"
            case attributes = "key.attributes"
            case bodylength = "key.bodylength"
            case bodyoffset = "key.bodyoffset"
            case diagnosticstage = "key.diagnostic_stage"
            case elements = "key.elements"
            case inheritedTypes = "key.inheritedtypes"
            case kind = "key.kind"
            case length = "key.length"
            case name = "key.name"
            case namelength = "key.namelength"
            case nameoffset = "key.nameoffset"
            case offset = "key.offset"
            case runtimename = "key.runtime_name"
            case substructure = "key.substructure"
            case typename = "key.typename"
        }
    }

    private enum CommandLineError: Error {
        case parseError
    }

    // MARK: - Main method

    mutating func run() throws {
        let path = FileManager.default.currentDirectoryPath
        var urlsUIKit: [String] = []
        var swiftUIUrls: [String] = []
        var testsUIKit: [String: String] = [:]
        var testsSwiftUI: [String: String] = [:]
        urlsUIKit = readSourceDirectory(path: generateUrl(for: "Source/AdmiralUIKit/Classes/Components", with: path), &urlsUIKit)
        swiftUIUrls = readSourceDirectory(path: generateUrl(for: "Source/AdmiralSwiftUI/Classes/Components", with: path), &swiftUIUrls)
        testsUIKit = readTestDirectory(path: generateUrl(for: "Tests/AdmiralUIKitTests/SnapshotTests", with: path), &testsUIKit)
        testsSwiftUI = readTestDirectory(path: generateUrl(for: "Tests/AdmiralSwiftUITests/SnapshotTests", with: path), &testsSwiftUI)
        print("AdmiralUIKit tests:")
        getInfo(by: urlsUIKit, testDictSource: testsUIKit)
        print("AdmiralSwiftUI tests:")
        getInfo(by: swiftUIUrls, testDictSource: testsSwiftUI)
    }

    // MARK: - 
    // let structure = try! Structure(file: file)
    // print(structure.description)
    private func getInfo(by urls: [String], testDictSource: [String: String]) {
        urls.forEach { fileUrl in
            guard let file = File(path: fileUrl),
                  let syntaxStructure = decodeSyntaxStructure(from: file),
                  let substructues = syntaxStructure.substructure
            else {
                return
            }

            let plainModels = substructues.map { subStruct in
                FileInfo(
                    name: subStruct.name ,
                    accesibility: subStruct.accessibility,
                    kind: subStruct.kind,
                    fileUrl: fileUrl,
                    isTestIncluded: testDictSource[subStruct.name ?? ""] != nil
                )
            }.filter { model in model.kind != .other && model.accesibility != .other }

            plainModels.forEach { item in print(item.isTestIncluded ? "✅" : "❌", item.name) }
        }
    }

    // MARK: - Decode
    /// Method decodes File model to SyntaxStructureDTO.
    private func decodeSyntaxStructure(from file: File) -> SyntaxStructureDTO? {
        do {
            let structure = try Structure(file: file)

            guard let jsonData = structure.description.data(using: .utf8) else {
                throw CommandLineError.parseError
            }

            return try JSONDecoder().decode(SyntaxStructureDTO.self, from: jsonData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    // MARK: - Read Directories
    /// Method loops through source directories and returns array of files with given filter.
    private func readSourceDirectory(path: String, _ arrayUrls: inout [String]) -> [String] {
        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: path)
            for item in items {
                let url = URL(fileURLWithPath: path + "/" + item)
                if url.isDirectory {
                    arrayUrls = readSourceDirectory(path: path + "/" + item, &arrayUrls)
                } else {
                    /// Filter block
                    if item.fileExtension == Constants.allowedFileExtension && !item.contains("Scheme") {
                        arrayUrls.append(path + "/" + item)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return arrayUrls
    }

    // Method loops through test directories and returns dict of files with given filter.
    private func readTestDirectory(path: String,_ dictUrls: inout [String: String]) -> [String: String] {
        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: path)
            for item in items {
                let url = URL(fileURLWithPath: path + "/" + item)
                if url.isDirectory {
                    dictUrls = readTestDirectory(path: path + "/" + item, &dictUrls)
                } else {
                    if item.fileExtension == Constants.allowedFileExtension {
                        if let filename = item.components(separatedBy: ".").first {
                            dictUrls[filename] = path + "/" + item
                        }
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return dictUrls
    }


    // MARK: - Generating Source URL

    /// Method generates URL path for given source including current location.
    private func generateUrl(for source: String, with path: String) -> String {
        var pathComponents = path.components(separatedBy: "/").filter { $0 != "" }
        pathComponents.removeSubrange(pathComponents.count - 2...pathComponents.count - 1)
        return "/" + pathComponents.joined(separator: "/") + "/" + source
    }

}

CommandLineParser.main()

// MARK: - Extensions

private extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}

private extension String {
    var fileExtension: String {
        URL(fileURLWithPath: self).pathExtension
    }
}
