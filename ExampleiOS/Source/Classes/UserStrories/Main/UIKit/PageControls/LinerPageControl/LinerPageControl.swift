//
//  LinerPageControl.swift
//  ExampleiOS
//
//  Created on 21.01.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralImages
import UIKit

final class LinerPageControl: BaseViewController {
    
    // MARK: - Private Properties
    
    private let pageControl = ScrollablePageControl()
    private var segmentControl = OutlineSliderTabSegmentedControl()
    private let nextButton = PrimaryButton()
    private let items = ["One", "Two", "Three",
                         "Four", "Five", "Six",
                         "Seven", "Eight", "Nine"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AppThemeable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        pageControl.apply(theme: theme)
        segmentControl.apply(theme: theme)
        nextButton.apply(theme: theme)
        
        nextButton.tintColor = theme.colors.elementStaticWhite.uiColor
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        addSubviews()
        configureConstraints()
        configureSegment()
        configurePageControl()
        configureButtons()
    }
    
    private func configurePageControl() {
        pageControl.numberOfPages = items.count
        pageControl.setCurrentPage(at: 0)
    }
    
    private func configureSegment() {
        segmentControl.setTitles(items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func configureButtons() {
        nextButton.setTitle("Next", for: [])
        nextButton.setImage(AdmiralImages.Asset.System.Outline.arrowRightOutline.image, for: .normal)
        nextButton.addTarget(self, action: #selector(tapNexButton), for: .touchUpInside)
        nextButton.semanticContentAttribute = .forceRightToLeft
        nextButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: LayoutGrid.doubleModule, bottom: 0.0, right: 0.0)
        nextButton.accessibilityIdentifier = "NextLiner"
    }
    
    private func addSubviews() {
        [segmentControl, pageControl, nextButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule),
            
            pageControl.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.module * 10),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: pageControl.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: LayoutGrid.module * 6),
            nextButton.heightAnchor.constraint(equalToConstant: LayoutGrid.halfModule * 10),
            nextButton.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 16)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.tripleModule)
        ])
    }
    
    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        pageControl.setCurrentPage(at: control.selectedSegmentIndex, animated: true)
    }
    
    @objc private func tapNexButton() {
        guard segmentControl.selectedSegmentIndex < items.count - 1 else { return }
        
        segmentControl.selectedSegmentIndex += 1
        pageControl.setCurrentPage(at: segmentControl.selectedSegmentIndex, animated: true)
    }

}
