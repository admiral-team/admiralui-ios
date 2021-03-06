//
//  StatusHistoryStandardViewController.swift
//  ExampleiOS
//
//  Created on 22.12.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class StatusHistoryStandardViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Private Properties
    
    private lazy var segmentedControl: OutlineSliderTabSegmentedControl = {
        let segment = OutlineSliderTabSegmentedControl(titles: StatusHistory.allCases.map({ $0.rawValue }))
        segment.addTarget(self, action: #selector(changeChangeSegment(_:)), for: .valueChanged)
        return segment
    }()
    
    private let inputNumber = InputNumber()
    private let statusView = StatusHistoryView(type: .standard)
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Public Properties
    
    func apply(theme: AppTheme) {
        inputNumber.apply(theme: theme)
        statusView.apply(theme: theme)
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        navigationItem.title = "Standard"
        
        inputNumber.text = "Image Count"
        inputNumber.minimumValue = 1
        inputNumber.value = 1
        inputNumber.maximumValue = 4
        inputNumber.addTarget(self, action: #selector(changeInputNumber), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        
        statusView.date = "10 Июля 2020, 20:31"
        statusView.images = [UIImage()]
        
        statusView.delegate = self
        statusView.sum = "+ 200 000 000 000 ₽"
        statusView.crossOutSum = "5 000 000 000 000 ₽"
        statusView.statusHistorySumType = .increase
        
        statusView.title = "Константин Н."
        statusView.subtitle = "Входящие переводы"
        
        statusView.statusText = "В обработке"
        statusView.statusImage = AdmiralUIResources.Asset.System.Solid.timeSolid.image
        statusView.status = .hold
        
        addSubviews()
        configureConstraints()
    }
    
    @objc private func changeInputNumber(_ inputNumber: InputNumber) {
        var images = [UIImage]()
        for _ in 0..<Int(inputNumber.value) {
            images.append(UIImage())
        }
        statusView.images = images
    }
    
    @objc private func changeChangeSegment(_ segment: OutlineSliderTabSegmentedControl) {
        let status = StatusHistory.allCases[segment.selectedSegmentIndex]
        
        switch status {
        case .hold:
            statusView.status = .hold
            statusView.statusText = "В обработке"
            statusView.statusImage = AdmiralUIResources.Asset.System.Solid.timeSolid.image
        case .attention:
            statusView.status = .review
            statusView.statusText = "Требуется подтверждение"
            statusView.statusImage = AdmiralUIResources.Asset.Service.Solid.infoSolid.image
        case .error:
            statusView.status = .error
            statusView.statusText = "Превышен лимит"
            statusView.statusImage = AdmiralUIResources.Asset.Service.Solid.errorSolid.image
        case .success:
            statusView.status = .done
            statusView.statusText = "Готов к выдаче"
            statusView.statusImage = AdmiralUIResources.Asset.Service.Solid.checkSolid.image
        case .sale:
            statusView.status = .done
            statusView.statusText = "Скидка 50% до 20 июля"
            statusView.statusImage = AdmiralUIResources.Asset.System.Solid.timeSolid.image
        }
    }
    
    private func addSubviews() {
        [segmentedControl, inputNumber, statusView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: LayoutGrid.doubleModule),
    
            inputNumber.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: LayoutGrid.doubleModule),
            inputNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: inputNumber.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.doubleModule),
            statusView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension StatusHistoryStandardViewController: StatusHistoryViewDelegate {
    
    func statusHistoryViewTapClose(view: StatusHistoryView) {}
    
}
