//
//  SwitcherListTableViewCell.swift
//  ExampleiOS
//
//  Created on 13.05.2021.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

class SwitcherListTableViewCellViewModel: TableViewListItem {
    let title: String
    let image: UIImage
    let isOn: Bool
    let key: String
    
    weak var delegate: SwitcherListTableViewCellDelegate?
    
    var reuseIdentifier: String {
        String(describing: SwitcherListTableViewCell.self)
    }
    
    var isEnabled: Bool = true
    var didSelect: (() -> Void)?

    init(title: String, image: UIImage, isOn: Bool, didSelect: (() -> Void)? = nil, key: String, isEnabled: Bool) {
        self.title = title
        self.image = image
        self.isOn = isOn
        self.didSelect = didSelect
        self.key = key
        self.isEnabled = isEnabled
    }
}

protocol SwitcherListTableViewCellDelegate: AnyObject {
    func didChangeSwitch(isOn: Bool, key: String?)
}

final class SwitcherListTableViewCell: TableListCell<ImageListView, TitleListView, SwitchListView>, TableViewListItemConfigurable {
   
    // MARK: - Public Properties
    
    weak var delegate: SwitcherListTableViewCellDelegate?
    var key: String?
    
    // MARK: - Private Properties
    
    private let switchListView = SwitchListView()
    private let titleListView = TitleListView()
    private let imageListView = ImageListView()
    
    // MARK: - Initializers
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        switchListView.apply(theme: theme)
        titleListView.apply(theme: theme)
        imageListView.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        selectionStyle = .none
        
        switchListView.didSelect = { [weak self] isOn in
            guard let self = self else { return }
            self.delegate?.didChangeSwitch(isOn: isOn, key: self.key)
        }
        
        listCell = ListCell(
            leadingView: imageListView,
            centerView: titleListView,
            tralingView: switchListView)
    }
    
    func configure(for item: TableViewListItem) {
        guard let item = item as? SwitcherListTableViewCellViewModel else { return }
        
        titleListView.title = item.title
        imageListView.image = item.image
        switchListView.isControlSelected = item.isOn
        delegate = item.delegate
        listCell?.isEnabled = item.isEnabled
        key = item.key
    }
    
}
