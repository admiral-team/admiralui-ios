//
//  AlertViewController.swift
//  AdmiralUI
//
//  Created on 09.11.2020.
//

import UIKit
import AdmiralTheme
/**
 AlertViewController - an custom object that displays an alert message to the user..
 You can create a AlertViewController with the zero frame rectangle by specifying the following parameters in init:
 ## Initializer parameters:
 - title: String? - The title of the alert.
 - message: String? - Descriptive text that provides more details about the reason for the alert.
 - image: UIImage? - The image of the alert view.
 - imageSizeType: AlertViewImageType - Type image size alert view.
 - actions: String - The actions that the user can take in response to the alert or action sheet..
 - messageLabelTextAlignment: String - Message label text alignment of alert view.
 - messageFont: String - Message label font style of alert view.
 - titleFont: String - Title label font style of alert view.
 - messageTextColor: String - Message label text color of alert view.
 - titleTextColor: String - Title label text color of alert view.

 ## Example to create AlertViewController
 # Code
 ```
     let vc = AlertViewController()
     vc.title = "Заголовок в одну или две строки"
     vc.message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
     vc.image = Asset.PopUp.popUpImage.image

     vc.modalPresentationStyle = .custom
     vc.modalTransitionStyle = .crossDissolve
     let action = AlertAction(title: "Хорошо", style: .primary) { (_) in
        vc.dismiss(animated: true, completion: nil)
     }
     vc.addAction(action)
```
 */
/// An custom object that displays an alert message to the user.
public class AlertViewController: UIViewController, AnyAppThemable {
    
    // MARK: - Public Properties
    
    /// The title of the alert.
    public override var title: String? {
        get { return alertView.title }
        set { alertView.title = newValue }
    }
    
    /// Descriptive text that provides more details about the reason for the alert.
    public var message: String? {
        get { return alertView.message }
        set { alertView.message = newValue }
    }
    
    /// The image of the alert.
    public var image: UIImage? {
        get { return alertView.image }
        set { alertView.image = newValue }
    }
    
    /// Type image size alert view.
    public var imageSizeType: AlertViewImageType {
        get { alertView.type }
        set { alertView.type = newValue }
    }

    /// Message label text alignment of alertView.
    public var messageLabelTextAlignment: NSTextAlignment {
        get {
            return alertView.messageLabelTextAlignment
        } set {
            alertView.messageLabelTextAlignment = newValue
        }
    }

    /// Message label number of lines of alertView.
    public var messageLabelNumberOfLines: Int {
        get {
            return alertView.messageLabelNumberOfLines
        } set {
            alertView.messageLabelNumberOfLines = newValue
        }
    }

    /// Title label text color of alertView.
    public var titleTextColor: AlertColorStyle {
        get {
            return alertView.titleTextColor
        } set {
            alertView.titleTextColor = newValue
        }
    }
    /// Message label text color of alertView.
    public var messageTextColor: AlertColorStyle {
        get {
            return alertView.messageTextColor
        } set {
            alertView.messageTextColor = newValue
        }
    }

    /// Message label font style of alertView.
    public var messageFont: AlertMessageFontStyle {
        get {
            return alertView.messageFont
        } set {
            alertView.messageFont = newValue
        }
    }
    /// Title label font style of alertView.
    public var titleFont: AlertTitleFontStyle {
        get {
            return alertView.titleFont
        } set {
            alertView.titleFont = newValue
        }
    }

    /// Override to customize layer width.
    public var preferredWidth: CGFloat? {
        didSet { configureLayout() }
    }
    
    /// Override to customize layer height.
    public var preferredHeight: CGFloat? {
        didSet { configureLayout() }
    }
    
    /// The actions that the user can take in response to the alert or action sheet.
    public var actions: [AlertAction] {
        return alertView.actions
    }

    /// Color scheme.
    public var scheme = AlertViewControllerScheme() {
        didSet { configure() }
    }

    // MARK: - Private Properties
    
    private var widthAlertViewConstraint: NSLayoutConstraint?
    private var heightAlertViewConstraint: NSLayoutConstraint?
    private var maxWidthDefaulttAlertViewConstraint: NSLayoutConstraint?
    
    private var alertView = DefaultAlertView()
    
    // MARK: - Initializer
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK: - Public Methods
    
    public func addAction(_ action: AlertAction) {
        alertView.addAction(action)
    }
    
    // MARK: - AnyAppThemable
    
    public func apply(theme: AppTheme) {
        scheme = AlertViewControllerScheme(theme: theme)
    }
 
    // MARK: - Private Methods
    
    private func commonInit() {
        apply(theme: .default)
        
        addSubviews()
        configureDefaultConstraint()
        configurationUI()
    }
    
    private func configure() {
        view.backgroundColor = scheme.backgroundColor.uiColor
        alertView.scheme = scheme.defaultAlertViewCustomScheme
    }
    
    private func configurationUI() {
        modalPresentationStyle = .overCurrentContext
    }
    
    private func addSubviews() {
        [alertView].addToSuperview(view)
    }
    
    private func configureDefaultConstraint() {
        let constraints = [
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(greaterThanOrEqualTo: alertView.trailingAnchor, constant: LayoutGrid.doubleModule),
            alertView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: LayoutGrid.quadrupleModule),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: alertView.bottomAnchor, constant: LayoutGrid.quadrupleModule),
        ]
        NSLayoutConstraint.activate(constraints)
        
        configureLayout()
    }
    
    private func configureLayout() {
        var deactivateConstraints = [NSLayoutConstraint]()
        if let heightAlertViewConstraint = heightAlertViewConstraint {
            deactivateConstraints.append(heightAlertViewConstraint)
        }
        if let widthAlertViewConstraint = widthAlertViewConstraint {
            deactivateConstraints.append(widthAlertViewConstraint)
        }
        if let maxWidthDefaulttAlertViewConstraint = maxWidthDefaulttAlertViewConstraint {
            deactivateConstraints.append(maxWidthDefaulttAlertViewConstraint)
        }
        NSLayoutConstraint.deactivate(deactivateConstraints)
        
        var activateConstraints = [NSLayoutConstraint]()
        
        if preferredHeight != nil || preferredWidth != nil {
            if let preferredHeight = self.preferredHeight {
                let heightAlertViewConstraint = alertView.heightAnchor.constraint(equalToConstant: preferredHeight)
                self.heightAlertViewConstraint = heightAlertViewConstraint
                activateConstraints += [heightAlertViewConstraint]
            }
            
            if let preferredWidth = self.preferredWidth {
                let widthAlertViewConstraint = alertView.widthAnchor.constraint(equalToConstant: preferredWidth)
                self.widthAlertViewConstraint = widthAlertViewConstraint
                activateConstraints += [widthAlertViewConstraint]
            }
        } else {
            let maxWidthDefaulttAlertViewConstraint = alertView.widthAnchor.constraint(lessThanOrEqualToConstant: LayoutGrid.halfModule * 100)
            self.maxWidthDefaulttAlertViewConstraint = maxWidthDefaulttAlertViewConstraint
            activateConstraints += [maxWidthDefaulttAlertViewConstraint]
        }
        

        NSLayoutConstraint.activate(activateConstraints)
    }
    
}
