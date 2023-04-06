//
//  AdditionalTextFieldView.swift
//  ExampleiOS
//
//  Created by on 21.03.2023.
//  
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class AdditionalTextFieldView: UIView, AnyAppThemable {
    
    // MARK: - Public Properties
    
    var isEnabled: Bool = true {
        didSet {
            tagViews.forEach({ $0.isEnabled = isEnabled })
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = LayoutGrid.halfModule * 3
        return stackView
    }()
    private(set) var tagViews = [TagControl]()
    private var scheme = AdditionalTextFieldViewCustomScheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Initializer

    init(tagViews: [TagControl<UIView, UIView>]) {
        self.tagViews = tagViews
        super.init(frame: .zero)
        
        configureUI()
        
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        tagViews.forEach({ stackView.addArrangedSubview($0) })
        stackView.addArrangedSubview(UIView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        scheme = AdditionalTextFieldViewCustomScheme(theme: theme)
        tagViews.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        [scrollView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        })
        
        [stackView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func updateScheme() {
        updateSchemeColors()
    }
    
    private func updateSchemeColors() {
        backgroundColor = scheme.backgroundColor.uiColor
    }

}
