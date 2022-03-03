//
//  StatusHistorySummaView.swift
//  AdmiralUI
//
//  Created on 21.12.2020.
//

import UIKit
import AdmiralTheme

class StatusHistorySumView: UIView, AnyAppThemable {
    
    enum Constants {
        static let noBrakeSpace = "\u{00a0}"
        static let space = " "
    }
    
    // MARK: - Internal Properties
    
    var type: StatusHistoryViewType = .standard {
        didSet { updateScheme() }
    }
    
    var statusHistorySumType: StatusHistorySumType = .decrease {
        didSet { updateScheme() }
    }
    
    var sum: String? {
        didSet { updateAttributeString() }
    }
    
    var crossOutSum: String? {
        didSet { updateAttributeString() }
    }
    
    var scheme = StatusHistorySumViewScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private var textLabel = UILabel()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    
    func apply(theme: AppTheme) {
        scheme = StatusHistorySumViewScheme(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func updateAttributeString() {
        let sum = (self.sum ?? "").replacingOccurrences(of: Constants.space, with: Constants.noBrakeSpace)
        let crossOutSum = (self.crossOutSum ?? "").replacingOccurrences(of: Constants.space, with: Constants.noBrakeSpace)
        var text = sum
        let countSpace = 3
        if !crossOutSum.isEmpty {
            for _ in 0..<countSpace {
                text += Constants.space
            }
            text += crossOutSum
        }
        
        guard let summaTextColor = scheme.sumTextColor.parameter(for: statusHistorySumType, type: type),
              let summaTextFont = scheme.sumTextFont.parameter(for: statusHistorySumType, type: type),
              let crossOutSummaTexColor = scheme.crossOutTextColor.parameter(for: statusHistorySumType, type: type),
              let crossOutSummaTexFont = scheme.crossOutTextFont.parameter(for: statusHistorySumType, type: type) else {
            textLabel.text = text
            return
        }
        
        let summaParameters: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: summaTextColor,
                                                               NSAttributedString.Key.font: summaTextFont]
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: text,
                                                                                   attributes: [.paragraphStyle: paragraph])
        
        attributeString.addAttributes(summaParameters, range: NSRange(location: 0, length: sum.count))
        if !crossOutSum.isEmpty {
            let location = sum.count + countSpace
            let length = attributeString.length - sum.count - countSpace
            let crossOutSummaParameters: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: crossOutSummaTexColor,
                                                                   NSAttributedString.Key.font: crossOutSummaTexFont]
            
            attributeString.addAttributes(crossOutSummaParameters, range: NSRange(location: location, length: length))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSRange(location: location, length: length))
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughColor,
                                         value: crossOutSummaTexColor,
                                         range: NSRange(location: location, length: length))
        }

        textLabel.attributedText = attributeString
    }
    
    private func updateScheme() {
        updateAttributeString()
    }
    
    private func commonInit() {
        apply(theme: defaultTheme)
        addSubviews()
        configureConstraints()
        configureUI()
    }
    
    private func configureUI() {
        textLabel.numberOfLines = 0
    }
    
    private func addSubviews() {
        [textLabel].addToSuperview(self)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.doubleModule),
            bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: LayoutGrid.doubleModule)
        ])
    }
}
