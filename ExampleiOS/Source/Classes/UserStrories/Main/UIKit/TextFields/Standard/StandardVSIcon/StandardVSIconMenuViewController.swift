//
//  StandardVSIconMenuViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class StandardVSIconMenuViewController: ScrollViewController {

    // MARK: - Private Properties

    private var textFields: [UIView] = []
    private let binder = KeyboardBinder()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideOutlineSegment(false)
        configureUI()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        binder.bindToKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        binder.unbindFromKeyboardNotifications()
    }

    // MARK: - AnyAppThemable

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        textFields.forEach({
            ($0 as? AppThemeCompatible)?.apply(theme: theme)
        })
    }

    // MARK: - Private Methods

    private func configureUI() {
        binder.bindable = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)

        configureTextFields()

        textFields.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }

        outlineSegmentControl.setTitles(["Default", "Read Only", "Error", "Disabled"])
        outlineSegmentControl.selectedSegmentIndex = 0
        outlineSegmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureTextFields() {
        let textFieldOne = createTextFieldView()
        textFields.append(textFieldOne)

        let textFieldTwo = createSecureTextFieldView()
        textFields.append(textFieldTwo)

        let textFieldThree = createTextView()
        textFields.append(textFieldThree)
        
        let textFieldAdditionalView = createTextFieldAdditionalView()
        textFields.append(textFieldAdditionalView)
    }

    private func createTextFieldView() -> TextFieldTextView {
        let textField = TextField()
        textField.name = "Optional label"
        textField.text = "Text"
        textField.placeholder = "Placeholder"
        textField.info = "Additional text"
        textField.inputTextAccessibilityId = "TextFieldInput"
        textField.accessibilityIdentifier = "TextField"

        let cell = TextFieldTextView(
            textField: textField,
            titleText: "Basic")

        return cell
    }

    private func createSecureTextFieldView() -> TextFieldTextView {
        let secureTextField = SecureTextField()
        secureTextField.textField.name = "Optional label"
        secureTextField.textField.text = "Text"
        secureTextField.textField.placeholder = "Placeholder"
        secureTextField.textField.info = "Additional text"
        secureTextField.textField.inputTextAccessibilityId = "SecureTextFieldnput"
        secureTextField.textField.accessibilityIdentifier = "SecureTextField"

        let cell = TextFieldTextView(
            textField: secureTextField,
            titleText: "Masked")

        return cell
    }

    private func createTextView() -> TextFieldTextView {
        let textView = TextView()
        textView.name = "Optional label"
        textView.text = "Text"
        textView.placeholder = "Placeholder"
        textView.info = "Additional text"
        textView.inputTextAccessibilityId = "TextViewInput"
        textView.accessibilityIdentifier = "TextView"

        let cell = TextFieldTextView(
            textField: textView,
            titleText: "Text View")

        return cell
    }
    
    private func createTextFieldAdditionalView() -> TextFieldTextView {
        let textField = TextField()
        let additionalView = createAdditionalView()
        textField.name = "Optional label"
        textField.text = "Text"
        textField.placeholder = "Placeholder"
        textField.info = "Additional text"
        textField.additionView = additionalView
        textField.inputTextAccessibilityId = "TextFieldInput"
        textField.accessibilityIdentifier = "TextField"

        let cell = TextFieldTextView(
            textField: textField,
            titleText: "+ Tags & Informer")

        return cell
    }
    
    private func createAdditionalView() -> UIView {
        var views: [TagControl<UIView, UIView>] = []
        for _ in 0..<5 {
            let emojiLabel = UILabel()
            emojiLabel.text = "💙"
            let view = TagControl()
            view.style = .default
            view.setTitle("Text")
            view.leadingView = emojiLabel
            
            views.append(view)
        }
        
        let tegCell = AdditionalTextFieldView(tagViews: views)

        return tegCell
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

    @objc private func didTap() {
        view.endEditing(true)
    }

    @objc private func segmentedValueChanged(_ control: OutlineSliderTabSegmentedControl) {
        var state: TextInputState = .normal
        switch control.selectedSegmentIndex {
        case 0:
            state = .normal
        case 1:
            state = .readOnly
        case 2:
            state = .error
        case 3:
            state = .disabled
        default:
            break
        }
        textFields.forEach({ ($0 as? TextFieldTextView)?.state = state })
    }

}

// MARK: - KeyboardBindable

extension StandardVSIconMenuViewController: KeyboardBindable {

    func keyboardFrameWillShow(info: KeyboardInfo) {
        scrollView.contentInset.bottom = info.frame.height
    }

    func keyboardFrameWillHide(info: KeyboardInfo) {
        scrollView.contentInset.bottom = 0
    }

}
