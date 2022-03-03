//
//  ColorEditViewController.swift
//  ExampleiOS
//
//  Created on 16.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

protocol ColorEditViewControllerDelegate: AnyObject {
    func didFinishEditing(_ viewController: ColorEditViewController)
}

final class ColorEditViewController: UIViewController {
    
    private enum Constants {
        static let hexRegex = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
    }
    
    var colorToken: ColorToken! {
        didSet { configureColor() }
    }
    
    weak var delegate: ColorEditViewControllerDelegate?
    
    private let textField = TextField()
    private let colorPicker = ColorPicker()
    private let bottomButton = PrimaryButton()
    private var bottomConstraint: NSLayoutConstraint?
    
    private let binder = KeyboardBinder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        binder.bindToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        binder.unbindFromKeyboardNotifications()
    }
    
    private func configureUI() {
        autoManage()
    
        addSubviews()
        configureConstraints()
        configureGestures()
        configureColor()
    
        bottomButton.setTitle("Готово", for: .normal)
        title = colorToken.name
        textField.delegate = self
        
        let imageView = UIImageView()
        imageView.image = AdmiralUIResources.Asset.System.Solid.editSolid.image
        textField.trailingView = imageView
        textField.returnKeyType = .done
        
        colorPicker.addTarget(self, action: #selector(handleColorChanged(picker:)), for: .valueChanged)
        bottomButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        binder.bindable = self
    }
    
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func addSubviews() {
        view.addSubview(colorPicker)
        view.addSubview(textField)
        view.addSubview(bottomButton)
    }
    
    private func configureConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: LayoutGrid.halfModule * 6)
        self.bottomConstraint = bottomConstraint
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.doubleModule),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: LayoutGrid.doubleModule),
            
            colorPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: colorPicker.trailingAnchor, constant: LayoutGrid.doubleModule),
            view.bottomAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 12 * LayoutGrid.module),
            
            bottomConstraint,
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor, constant: LayoutGrid.doubleModule),
            bottomButton.heightAnchor.constraint(equalToConstant: LayoutGrid.module * 6)
        ])
    }
    
    @objc private func buttonTap() {
        colorToken = ColorToken(color: colorPicker.color, name: colorToken.name)
        delegate?.didFinishEditing(self)
    }
    
    @objc private func didTapScreen() {
        textField.resignFirstResponder()
    }
    
    @objc private func handleColorChanged(picker: ColorPicker) {
        if textField.isEditing {
            textField.resignFirstResponder()
        }
        colorToken = ColorToken(color: colorPicker.color, name: colorToken.name)
    }
    
    private func configureColor() {
        colorPicker.set(color: colorToken.color)
        textField.text = colorToken.hex
    }
    
}

// MARK: - AnyAppThemable

extension ColorEditViewController: AnyAppThemable {
    
    func apply(theme: AppTheme) {
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        textField.trailingView?.tintColor = theme.colors.textAccent.uiColor
        textField.apply(theme: theme)
        bottomButton.apply(theme: theme)
    }
    
}

// MARK: - KeyboardBindable

extension ColorEditViewController: KeyboardBindable {
    
    func keyboardFrameWillChangeFrame(info: KeyboardInfo) {
        bottomConstraint?.constant = info.bottomOffset + LayoutGrid.halfModule * 3
        UIView.animate(withDuration: info.duration, delay: 0, options: info.curve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

// MARK: - TextFieldDelegate

extension ColorEditViewController: TextFieldInputDelegate {
    
    @objc func textFieldInputDidChange(_ textField: TextFieldInput) {
        let prefix = "#"
        let text = textField.text ?? ""
        var newText = ""

        if !text.hasPrefix(prefix) {
            newText = prefix + text
        } else {
            newText = text
        }
        
        self.textField.info = nil
        self.textField.state = .normal
        self.textField.text = newText.uppercased()
    }
    
    func textFieldInputShouldReturn(_ textField: TextFieldInput) -> Bool {
        let hexString = textField.text ?? ""
        let isValid = hexString.matches(Constants.hexRegex)
        
        if isValid {
            colorToken = ColorToken(color: UIColor(hexString: hexString), name: colorToken.name)
            self.textField.resignFirstResponder()
        } else {
            self.textField.info = "Неправильный формат"
            self.textField.state = .error
        }
        
        return isValid
    }
    
}
