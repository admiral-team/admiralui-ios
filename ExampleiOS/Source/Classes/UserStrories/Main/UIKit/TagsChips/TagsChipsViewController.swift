//
//  TagsChipsViewController.swift
//  Example iOS
//
//  Created on 15.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class TagsChipsViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private enum Constants {
        static let additionalViewSize = CGSize(
            width: LayoutGrid.halfModule * 6,
            height: LayoutGrid.halfModule * 6)
    }
    private var views = [TagCellView]()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        views.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureSegmentControl()
        configureDefaultTags()
        configureAdditionalTags()
        configureSuccessTags()
        configureErrorTags()
        configureAttentionTags()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSegmentControl() {
        segmentControl.setItems([
            StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
            StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")]
        )
    }
    
    private func configureDefaultTags() {
        let view1 = createTagWithImageAndButtonView(
            "Chip",
            image: Asset.TagsChips.carSolid.image,
            buttonImage: AdmiralUIResources.Asset.Service.Solid.closeSolid.image,
            style: .default)
        
        let view2 = createTagWithButtonView(
            "Chip",
            buttonImage: AdmiralUIResources.Asset.Service.Solid.closeSolid.image,
            style: .default)
        
        let view3 = createTagWithImageView(
            "Icons",
            image: Asset.TagsChips.carSolid.image,
            style: .default)
        
        let view4 = createTagWithImageView(
            "Flag",
            image: Asset.TagsChips.russiaFlag.image,
            style: .default)
        
        addTags(views: [view1, view2, view3, view4], titleText: "Default")
    }
    
    private func configureAdditionalTags() {
        let view1 = createTagWithImageView(
            "Icons",
            image: Asset.TagsChips.carSolid.image,
            style: .additional)
        
        let view2 = createTagWithImageAndEmojiView(
            "Emoji",
            emoji: "🐶",
            style: .additional)
        
        let view3 = createTagWithImageView(
            "Flags",
            image: Asset.TagsChips.russiaFlag.image,
            style: .additional)
        
        addTags(views: [view1, view2, view3], titleText: "Additional")
    }
    
    private func configureSuccessTags() {
        let view1 = createTagWithImageView(
            "Icons",
            image: Asset.TagsChips.carSolid.image,
            style: .success)
        
        let view2 = createTagWithImageAndEmojiView(
            "Emoji",
            emoji: "🐶",
            style: .success)
        
        let view3 = createTagWithImageView(
            "Flags",
            image: Asset.TagsChips.russiaFlag.image,
            style: .success)
        
        addTags(views: [view1, view2, view3], titleText: "Success")
    }
    
    private func configureErrorTags() {
        let view1 = createTagWithImageView(
            "Icons",
            image: Asset.TagsChips.carSolid.image,
            style: .error)
        
        let view2 = createTagWithImageAndEmojiView(
            "Emoji",
            emoji: "🐶",
            style: .error)
        
        let view3 = createTagWithImageView(
            "Flags",
            image: Asset.TagsChips.russiaFlag.image,
            style: .error)
        
        addTags(views: [view1, view2, view3], titleText: "Error")
    }
    
    private func configureAttentionTags() {
        let view1 = createTagWithImageView(
            "Icons",
            image: Asset.TagsChips.carSolid.image,
            style: .attention)
        
        let view2 = createTagWithImageAndEmojiView(
            "Emoji",
            emoji: "🐶",
            style: .attention)
        
        let view3 = createTagWithImageView(
            "Flags",
            image: Asset.TagsChips.russiaFlag.image,
            style: .attention)
        
        addTags(views: [view1, view2, view3], titleText: "Attention")
    }
    
    private func createSimpleTagView(_ title: String, style: TagStyle) -> TagControl<UIView, UIView> {
        let view = TagControl()
        view.style = style
        view.setTitle(title)
        return view
    }
    
    private func createTagWithImageView(_ title: String, image: UIImage, style: TagStyle) -> TagControl<UIView, UIView> {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: Constants.additionalViewSize))
        imageView.image = image
        let view = TagControl()
        view.style = style
        view.setTitle(title)
        view.leadingView = imageView
        return view
    }
    
    private func createTagWithImageAndEmojiView(_ title: String, emoji: String, style: TagStyle) -> TagControl<UIView, UIView> {
        let emojiLabel = UILabel()
        emojiLabel.text = emoji
        let view = TagControl()
        view.style = style
        view.setTitle(title)
        view.leadingView = emojiLabel
        return view
    }
    
    private func createTagWithButtonView(_ title: String, buttonImage: UIImage, style: TagStyle) -> TagControl<UIView, UIView> {
        let button = UIButton(frame: CGRect(origin: .zero, size: Constants.additionalViewSize))
        button.setImage(buttonImage, for: .normal)
        let view = TagControl()
        view.style = style
        view.setTitle(title)
        view.trailingView = button
        return view
    }
    
    private func createTagWithImageAndButtonView(_ title: String, image: UIImage, buttonImage: UIImage, style: TagStyle) -> TagControl<UIView, UIView> {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: Constants.additionalViewSize))
        imageView.image = image
        
        let button = UIButton(frame: CGRect(origin: .zero, size: Constants.additionalViewSize))
        button.setImage(buttonImage, for: .normal)
        let view = TagControl()
        view.style = style
        view.setTitle(title)
        view.leadingView = imageView
        view.trailingView = button
        return view
    }
    
    private func createPrimaryLink(_ title: String, image: UIImage) -> PrimaryLinkControl {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: Constants.additionalViewSize))
        imageView.image = image
        
        let linkView = PrimaryLinkControl()
        linkView.leadingImage = image
        linkView.setTitle(title)
        return linkView
    }
    
    private func addTags(views: [TagControl<UIView, UIView>], titleText: String) {
        let cell = TagCellView(tagViews: views, titleText: titleText)
        self.views.append(cell)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
