//
//  UploadingImageGroupView.swift
//  AdmiralUIResources
//
//  Created on 09.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 UploadingImageGrid - the component that used to add imageViews to group
 
 You can create a UploadingImageGroupView with the zero frame rectangle by specifying the following parameters in init:
 
 - models: list of imageView models
 - direction: direction message
 
 ## Example to create UploadingImageGrid
 # Code
 ```
 public var body: some View {
 let testModel = UploadImageModel(
 isLoading: .constant(true),
 time: "14:52",
 backgroundImage: nil
 )
 UploadingImageGrid(models: [testModel], direction: .left)
 }
 ```
 */
@available(iOS 14.0.0, *)
public struct UploadingImageGrid: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let gridColumnsCount: Int = 2
        static let verticalSpacing: CGFloat = 10
        static let maximumElemenetsInGrid = 6
        static let leftPadding: CGFloat = 110
    }

    // MARK: - Public properties

    /// Tapped index of  element.
    public var tappedModel: ((UploadImageModel) -> ())?
    
    // MARK: - Private properties
    
    private var models: [UploadImageModel]
    
    private let grid: [String: [[UploadImageViewCornerStyle]]] = [
        "1" : [[.allSides]],
        "2" : [[.leftSide, .rightSide]],
        "3" : [[.top], [.bottomLeft, .bottomRight]],
        "4" : [[.topLeft, .topRight], [.bottomLeft, .bottomRight]],
        "5" : [[.top], [.none, .none], [.bottomLeft, .bottomRight]],
        "6" : [[.topLeft, .topRight], [.none, .none], [.bottomLeft, .bottomRight]]
    ]
    
    private var rows: [[UploadImageModel]] {
        models.chunks(Constants.gridColumnsCount)
    }
    
    private var gridCount: Int {
        models.count <= Constants.maximumElemenetsInGrid ? models.count : Constants.maximumElemenetsInGrid
    }
    
    /// Direction message.
    private let direction: ChatDirection
    
    /// Action error button.
    private var errorAction: () -> ()

    /// Scheme provider serves for changing scheme while change theme.
    @ObservedObject private var schemeProvider: SchemeProvider<UploadImageViewScheme>
    
    // MARK: - Init/deinit
    
    public init(
        models: [UploadImageModel],
        direction: ChatDirection,
        tappedModel: ((_ model: UploadImageModel) -> Void)? = nil,
        schemeProvider: SchemeProvider<UploadImageViewScheme> = AppThemeSchemeProvider<UploadImageViewScheme>(),
        errorAction: @escaping () -> () = {}
    ) {
        self.models = models
        self.direction = direction
        self.tappedModel = tappedModel
        self.errorAction = errorAction
        self.schemeProvider = schemeProvider
    }
    
    public init(
        model: UploadImageModel,
        direction: ChatDirection,
        tappedModel: ((_ model: UploadImageModel) -> Void)? = nil,
        schemeProvider: SchemeProvider<UploadImageViewScheme> = AppThemeSchemeProvider<UploadImageViewScheme>(),
        errorAction: @escaping () -> () = {}
    ) {
        self.init(
            models: [model],
            direction: direction,
            tappedModel: tappedModel,
            schemeProvider: schemeProvider,
            errorAction: errorAction
        )
    }
    
    // MARK: - Layout
    
    public var body: some View {
        contentView()
    }
    
    // MARK: - Private methods
    @ViewBuilder
    private func contentView() -> some View {
        switch direction {
        case .left:
            HStack(alignment: .bottom, spacing: LayoutGrid.halfModule) {
                uploadImageViews()
                Spacer()
            }
            .eraseToAnyView()
            
        case .right:
            HStack(alignment: .bottom, spacing: LayoutGrid.halfModule) {
                Spacer()
                uploadImageViews()
                statusError()
            }
            .eraseToAnyView()
        }
    }
    
    private func uploadImageViews() -> some View {
        VStack(spacing: LayoutGrid.module) {
            ForEach(rows.indices, id: \.self) { index in
                if let cornerList = grid[String(gridCount)] {
                    HStack(spacing: LayoutGrid.module) {
                        ForEach(0..<rows[index].count, id:\.self) { modelIndex in
                            UploadImageView(
                                model: rows[index][modelIndex],
                                direction: direction,
                                cornersStyle: cornerList[index][modelIndex],
                                schemeProvider: schemeProvider
                            )
                            .onTapGesture {
                                tappedModel?(rows[index][modelIndex])
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func statusError() -> some View {
        return VStack {
            if isStatusError() {
                Image(uiImage: PrivateAsset.Custom.Chat.error.image)
                    .padding(.top, LayoutGrid.module)
                    .frame(width: LayoutGrid.module * 5, height: LayoutGrid.module * 5)
                    .onTapGesture {
                        errorAction()
                    }
            }
        }
    }
    
    private func isStatusError() -> Bool {
        models.contains(where: {
            $0.uploadStatus == .error
        })
    }
}

private extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to:count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, count)])
        }.reversed()
    }
}

@available(iOS 14.0, *)
struct UploadingImageGroupView_Previews: PreviewProvider {
    
    static var previews: some View {
        let testModel = UploadImageModel(
            isLoading: true,
            time: "14:52",
            backgroundImage: nil,
            uploadStatus: .read)
        VStack {
            UploadingImageGrid(models: [testModel, testModel, testModel, testModel, testModel],
                               direction: .left)
        }
        .padding()
    }
    
}
