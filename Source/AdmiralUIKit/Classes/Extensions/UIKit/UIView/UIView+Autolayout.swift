//
//  UIView+Autolayout.swift
//  AdmiralUI
//
//  Created on 12.10.2020.
//

import UIKit


// MARK: - Autolayout

extension UIView {
    
    public struct DirectionalEdgeInsets {
        public let top: CGFloat
        public let bottom: CGFloat
        public let leading: CGFloat
        public let trailing: CGFloat
        
        public static let zero = DirectionalEdgeInsets()
        
        public init(
            top: CGFloat = 0,
            bottom: CGFloat = 0,
            leading: CGFloat = 0,
            trailing: CGFloat = 0
        ) {
            self.top = top
            self.bottom = bottom
            self.leading = leading
            self.trailing = trailing
        }
    }
    
    public struct LayoutDirection: OptionSet {
        public let rawValue: Int
        
        public static let top = LayoutDirection(rawValue: 1 << 0)
        public static let bottom = LayoutDirection(rawValue: 1 << 1)
        public static let leading = LayoutDirection(rawValue: 1 << 2)
        public static let trailing = LayoutDirection(rawValue: 1 << 3)
        
        public static let all: [LayoutDirection] = [.top, bottom, .leading, .trailing]
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    public func fillView(
        view: UIView,
        padding: DirectionalEdgeInsets = .zero,
        ignore: LayoutDirection = [],
        priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        if !ignore.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top))
        }
        
        if !ignore.contains(.bottom) {
            constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom))
        }
        
        if !ignore.contains(.leading) {
            constraints.append(leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.leading))
        }
        
        if !ignore.contains(.trailing) {
            constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.trailing))
        }
        
        return constraints
    }
    
    public func fillGuide(
        guide: UILayoutGuide,
        padding: DirectionalEdgeInsets = .zero,
        ignore: LayoutDirection = [],
        priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        if !ignore.contains(.top) {
            constraints.append(topAnchor.constraint(equalTo: guide.topAnchor, constant: padding.top))
        }
        
        if !ignore.contains(.bottom) {
            constraints.append(guide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom))
        }
        
        if !ignore.contains(.leading) {
            constraints.append(leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: padding.leading))
        }
        
        if !ignore.contains(.trailing) {
            constraints.append(guide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.trailing))
        }
        
        return constraints
    }
        
}

// MARK: - Add Subviews

extension UIView {
    
    func addSubviews(_ subviews: [UIView], translatesAutoresizingMaskIntoConstraints: Bool = false) {
        subviews.forEach() {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        }
    }
    
}

extension Array where Element == UIView {
    
    public func addToSuperview(_ superView: UIView, translatesAutoresizingMaskIntoConstraints: Bool = false) {
        forEach() {
            superView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        }
    }
    
}

extension Array where Element == NSLayoutConstraint {
    
    public func activate() {
        NSLayoutConstraint.activate(self)
    }
    
    public func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
    
}
