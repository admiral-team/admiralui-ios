//
//  CardViewController.swift
//  ExampleiOS
//
//  Created on 25.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class CardViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Private Properties
    
    private let cardView = CardView()
    private let viewModel = CardViewModel()
    private let segmentControl = StandardSegmentedControl(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        cardView.apply(theme: theme)
        segmentControl.apply(theme: theme)
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        configureViews()
        configureSegment()
        configureConstraints()
    }

    private func configureSegment() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.insertTitle("Default", forSegmentAt: 0)
        segmentControl.insertTitle("Disabled", forSegmentAt: 1)
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func configureViews() {
        cardView.topLabelText = viewModel.topLabelText
        cardView.nameLabelText = viewModel.nameLabelText
        cardView.amountLabelText = viewModel.amountLabelText
        cardView.backgroundImage = Asset.Headers.cardSample.image
        cardView.cardPaymenSystemFirstImage = Asset.Headers.visaSample.image
        cardView.cardPaymentSystemSecondImage = Asset.Headers.maserCardSample.image
        cardView.statusLabelText = viewModel.statusLabelText
        cardView.subtitleLabelText = viewModel.subtitleLabelText
        cardView.statusImage = Asset.Headers.lock.image
    }
    
    private func addSubviews() {
        [cardView,
         segmentControl].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.module * 11),
            cardView.widthAnchor.constraint(equalToConstant: 260.0),
            cardView.heightAnchor.constraint(equalToConstant: 164.0),
            
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.tripleModule)
        ])
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        if control.selectedSegmentIndex == 0 {
            cardView.cardStatusStyle = .noStatus
        } else if control.selectedSegmentIndex == 1 {
            cardView.cardStatusStyle = .error
        }
    }

}
