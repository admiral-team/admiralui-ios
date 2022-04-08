//
//  EditSingleTextViewController.swift
//  ExampleiOS
//
//  Created on 19.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

protocol EditSingleTextViewControllerDelegate: AnyObject {
    func didEndEditText(_ viewController: EditSingleTextViewController)
    func enableAction(_ viewController: EditSingleTextViewController) -> Bool
}

final class EditSingleTextViewController: UIViewController {
    
    weak var delegate: EditSingleTextViewControllerDelegate?
    
    var text: String? {
        didSet {
            updateTextField()
            updateBottonButtonEnable()
        }
    }
    
    var textEditName: String? {
        didSet { updateTextField() }
    }
    
    var textPlaceholder: String? {
        didSet { updateTextField() }
    }
    
    var actionName: String? {
        didSet { updateBottomButton() }
    }
    
    var infoMessage: String? {
        didSet { updateInfoLabel() }
    }
    
    private var firstDidAppear: Bool = true
          
    // MARK: - Private Properties
    
    private let infoView = ThemeInfoHeaderView()
    private let textField = TextField()
    private let bottomButton = PrimaryButton()
    private var bottomConstraint: NSLayoutConstraint?
    
    private let binder = KeyboardBinder()
    
    // MARK: - Public Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        binder.bindToKeyboardNotifications()
        
        if firstDidAppear {
            textField.becomeFirstResponder()
            firstDidAppear = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        binder.unbindFromKeyboardNotifications()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
        configureConstraints()
        configureGestures()
        
        binder.bindable = self
        infoView.infoLabel.numberOfLines = 0
        
        textField.delegate = self
        
        updateTextField()
        updateInfoLabel()
        updateBottomButton()
        updateBottonButtonEnable()
        
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        [infoView, textField, bottomButton].addToSuperview(view)
        
        let bottomConstraint = view.bottomSafeAreaAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: LayoutGrid.halfModule * 6)
        self.bottomConstraint = bottomConstraint
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),

            textField.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: LayoutGrid.doubleModule),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            bottomConstraint,
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6)
        ])
    }
    
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func didTapScreen() {
        view.endEditing(true)
    }
    
    @objc private func didTapBottomButton() {
        delegate?.didEndEditText(self)
    }
    
    private func updateTextField() {
        guard isViewLoaded else { return }
        textField.name = textEditName
        textField.placeholder = textPlaceholder
        textField.text = text
    }
    
    private func updateInfoLabel() {
        guard isViewLoaded else { return }
        infoView.infoLabel.text = infoMessage
    }
    
    private func updateBottomButton() {
        guard isViewLoaded else { return }
        bottomButton.setTitle(actionName, for: .normal)
    }
    
    private func updateBottonButtonEnable() {
        guard isViewLoaded else { return }
        bottomButton.isEnabled = delegate?.enableAction(self) ?? true
    }
    
}

// MARK: - AnyAppThemable

extension EditSingleTextViewController: AnyAppThemable {
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        infoView.apply(theme: theme)
        textField.apply(theme: theme)
    }
    
}

// MARK: - TextFieldDelegate

extension EditSingleTextViewController: TextFieldInputDelegate {
    
    @objc func textFieldInputDidChange(_ textField: TextFieldInput) {
        text = textField.text
        updateBottonButtonEnable()
    }
    
    func textFieldInputShouldReturn(_ textField: TextFieldInput) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - KeyboardBindable

extension EditSingleTextViewController: KeyboardBindable {
        
    func keyboardFrameWillChangeFrame(info: KeyboardInfo) {
        let window = UIApplication.shared.windows.first
        let bottomInset = window?.safeAreaInsets.bottom ?? 0
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        var bottomOffset: CGFloat = 0.0
        if tabBarHeight != 0 && bottomInset != 0 {
            bottomOffset = LayoutGrid.halfModule * 8
        }
        var keyboardBottomOffset: CGFloat = 0.0
        if info.bottomOffset == 0 {
            keyboardBottomOffset = LayoutGrid.halfModule * 6
        } else {
            keyboardBottomOffset = info.frame.height
            + LayoutGrid.doubleModule
            + bottomOffset
            - bottomInset
            - tabBarHeight
        }
        bottomConstraint?.constant = keyboardBottomOffset
        UIView.animate(withDuration: info.duration, delay: 0, options: info.curve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
