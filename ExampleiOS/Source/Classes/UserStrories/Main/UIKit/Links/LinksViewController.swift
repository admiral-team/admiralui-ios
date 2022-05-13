//
//  LinksViewController.swift
//  ExampleiOS
//
//  Created on 09.02.2021.
//

import UIKit
import AdmiralUIKit

final class LinksViewController: ScrollViewController {
    
    // MARK: - Private Properties

    private let viewModel = LinksViewModel()
    private var views = [LinksCellView]()
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureLinks()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        
        segmentControl.setTitles(viewModel.tabsItems)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureLinks() {
        viewModel.links.forEach { link in
            var links: [PrimaryLinkControl] = []
            link.links.forEach {
                let view = PrimaryLinkControl()
                view.title = $0.text
                view.style = $0.style
                view.fontStyle = $0.fontStyle
                switch $0.position {
                case .trailing:
                    view.trailingView = UIImageView(image: $0.image)
                case .leading:
                    view.leadingView = UIImageView(image: $0.image)
                default:
                    break
                }
                links.append(view)
            }
            addTags(views: links, titleText: link.type)
        }
    }
    
    private func addTags(views: [PrimaryLinkControl], titleText: String) {
        let cell = LinksCellView(linkViews: views, titleText: titleText)
        self.views.append(cell)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
