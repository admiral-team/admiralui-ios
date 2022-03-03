//
//  SpinnerViewController.swift
//  Example iOS
//
//  Created on 16.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SpinnerViewController: BaseViewController {
    
    // MARK: - Private Properties
    
    private let activityIndicatorView = ActivityIndicator()
    private let segmentControl = StandardSegmentedControl(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        segmentControl.apply(theme: theme)
        activityIndicatorView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
    
        addSubviews()
        configureSegment()
        configureConstraints()
        configureActivity()
        
        presentIndicator()
    }
    
    private func configureActivity() {
        activityIndicatorView.size = .small
    }
    
    private func configureSegment() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.insertTitle("Small", forSegmentAt: 0)
        segmentControl.insertTitle("Medium", forSegmentAt: 1)
        segmentControl.insertTitle("Big", forSegmentAt: 2)
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func addSubviews() {
        [activityIndicatorView, segmentControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.module * 11),
            
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.tripleModule)
        ])
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let size = ActivityIndicator.Size(rawValue: control.selectedSegmentIndex) else { return }
        
        dismissIndicator()
        activityIndicatorView.size = size
        presentIndicator()
    }
    
    @objc private func presentIndicator() {
        self.activityIndicatorView.startAnimating()
    }
    
    @objc private func dismissIndicator() {
        self.activityIndicatorView.stopAnimating()
    }

}
