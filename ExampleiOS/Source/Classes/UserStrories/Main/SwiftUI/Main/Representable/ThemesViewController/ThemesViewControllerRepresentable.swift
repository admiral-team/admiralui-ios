//
//  ThemesViewControllerRepresentable.swift
//  ExampleiOS
//
//  Created on 08.07.2021.
//

import SwiftUI

@available(iOS 14.0, *)
struct ThemesViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ThemesViewControllerRepresentable>) -> ThemesViewController {
        let viewController = ThemesViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: ThemesViewController, context: UIViewControllerRepresentableContext<ThemesViewControllerRepresentable>) {
    }
}
