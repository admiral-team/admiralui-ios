//
//  LinerPageControl.swift
//  ExampleiOS
//
//  Created on 21.01.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class LinerPageControl: UIViewController, AppThemeable {
    
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
    
    func apply(theme: AppTheme) {
        pageControl.apply(theme: theme)
        segmentControl.apply(theme: theme)
        nextButton.apply(theme: theme)
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
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
        nextButton.addTarget(self, action: #selector(tapNexButton), for: .touchUpInside)
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
            nextButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6),
            nextButton.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 14)
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
