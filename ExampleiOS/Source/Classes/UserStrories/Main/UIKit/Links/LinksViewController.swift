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
    
    private var views = [LinksCellView]()
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureBigLinks()
        configureSmallLinks()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureBigLinks() {
        let view1 = PrimaryLinkControl()
        view1.title = "Link"
        view1.style = .none
        view1.fontStyle = .body
        view1.leadingView = UIImageView(image: UIImage(asset: Asset.Links.arrowLeftBig))
        
        let view2 = PrimaryLinkControl()
        view2.style = .none
        view2.fontStyle = .body
        view2.trailingView = UIImageView(image: UIImage(asset: Asset.Links.arrowRightBig))
        view2.title = "Link"
        
        let view3 = PrimaryLinkControl()
        view3.fontStyle = .body
        view3.style = .none
        view3.title = "Link"
        
        addTags(views: [view1, view2, view3], titleText: "24 Link")
    }
    
    private func configureSmallLinks() {
        let view1 = PrimaryLinkControl()
        view1.title = "Link"
        view1.style = .none
        view1.fontStyle = .subhead
        view1.leadingView = UIImageView(image: UIImage(asset: Asset.Links.arrowLeftSmall))
        
        let view2 = PrimaryLinkControl()
        view2.style = .none
        view2.fontStyle = .subhead
        view2.trailingView = UIImageView(image: UIImage(asset: Asset.Links.arrowRightSmall))
        view2.title = "Link"
        
        let view3 = PrimaryLinkControl()
        view3.fontStyle = .subhead
        view3.style = .none
        view3.title = "Link"
        
        addTags(views: [view1, view2, view3], titleText: "18 Link")
    }
    
    private func addTags(views: [PrimaryLinkControl], titleText: String) {
        let cell = LinksCellView(linkViews: views, titleText: titleText)
        self.views.append(cell)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
