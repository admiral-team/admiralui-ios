//
//  CircularPageControlViewController.swift
//  ExampleiOS
//
//  Created on 27.01.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class CircularPageControlViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    private let pageControl = CirclePageControl()
    private var segmentControl = OutlineSliderTabSegmentedControl()
    private let viewModel = CirclePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AppThemeable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        segmentControl.apply(theme: theme)
        pageControl.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        configureConstraints()
        configureSegment()
        configurePageControl()
    }
    
    private func configurePageControl() {
        pageControl.delegate = self
        pageControl.duration = 0.3
        pageControl.totalPages = segmentControl.selectedSegmentIndex + 1
        pageControl.currentPage = viewModel.currentIndex
    }
    
    private func configureSegment() {
        segmentControl.setTitles(viewModel.items)
        segmentControl.setSelectedSegmentIndex(viewModel.currentIndex, animated: false)
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func addSubviews() {
        [segmentControl, pageControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule),
            
            pageControl.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.halfModule * 25),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: LayoutGrid.module * 9),
            pageControl.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 9)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.tripleModule)
        ])
    }
    
    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        pageControl.totalPages = control.selectedSegmentIndex + 1
        pageControl.setPage(viewModel.currentIndex, animated: false)
    }

}

// MARK: - CirclePageControlDelegate

extension CircularPageControlViewController: CirclePageControlDelegate {
    
    func didTapCenterButton() {
        if pageControl.currentPage < segmentControl.selectedSegmentIndex + 1 {
            pageControl.setPage(pageControl.currentPage + 1, animated: true)
        } else {
            if segmentControl.selectedSegmentIndex == viewModel.items.count - 1 {
                segmentControl.setSelectedSegmentIndex(0, animated: true)
            } else {
                segmentControl.selectedSegmentIndex += 1
            }
        }
    }

}
