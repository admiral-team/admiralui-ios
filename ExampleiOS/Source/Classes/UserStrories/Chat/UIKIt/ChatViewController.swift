//
//  ChatViewController.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import UIKit

final class ChatViewController: BaseTableViewController {

    // MARK: - Private properties

    private let viewModel = ChatViewModel()

    // MARK: - Initializer

    override func viewDidLoad() {
        setSegmentControl(hidden: true)

        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableViewManager.sections = createSections()
    }

    // MARK: - Private Methods

    private func createSections() -> [MainSectionViewModel] {
        let items = viewModel.items.map { item -> MainTitleTableViewCellViewModel in
            let title = item.getTitle()
            return MainTitleTableViewCellViewModel(
                title: title,
                didSelect: { [weak self] in self?.presentVC(item: item, title: title) }
            )
        }
        return [MainSectionViewModel(items: items)]
    }

}

private extension ChatViewController {

    func presentVC(item: ChatViewModel.Items, title: String) {
        var vc: UIViewController
        switch item {
        case .uploadingFiles:
            vc = UploadingFileViewController()
        case .uploadingPhoto:
            vc = UploadingImageViewController()
        case .input:
            vc = InputChatViewController()
        case .message:
            vc = TextMessageViewController()
        case .operation:
            vc = TextOperationViewController()
        }
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }

}
