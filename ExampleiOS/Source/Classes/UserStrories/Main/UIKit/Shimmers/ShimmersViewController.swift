//
//  ShimmersViewController.swift
//  ExampleiOS
//
//  Created on 16.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ShimmersViewController: ScrollViewController {

    // MARK: - Private Properties
    
    private var cells: [ShimmerCellView] = []
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        cells.forEach({
            $0.apply(theme: theme)
        })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureCells()
        
        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureCells() {
        let view1 = ShimmerCellView(state: .rightImageShimmering)
        let view2 = ShimmerCellView(state: .leftImageShimmering)
        let view3 = ShimmerCellView(state: .subtitleShimmering)
        let view4 = ShimmerCellView(state: .wholeViewShimmering)
        
        cells.append(contentsOf: [view1, view2, view3, view4])
    }
    
}
