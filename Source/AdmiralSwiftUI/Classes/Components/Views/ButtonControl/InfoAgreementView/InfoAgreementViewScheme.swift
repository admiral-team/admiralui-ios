//
//  InfoAgreementViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 InfoAgreementViewScheme - the visual scheme of InfoAgreementView.
  You can create a by specifying the following parameters in init:
  - InfoAgreementViewScheme() - Initialize default InfoAgreementViewScheme with default themezation
  # Example to create InfoAgreementViewScheme:
  # Code
  ```
 let scheme = InfoAgreementViewScheme()
  ```
  */
public struct InfoAgreementViewScheme: AppThemeScheme {

     // MARK: - Properties

     /// The title color of InfoAgreementView
     public var titleColor: AColor

     /// The title font of InfoAgreementView
     public var titleFont: AFont

     // MARK: - Initializer

     public init(theme: AppTheme = .default) {
         titleColor = theme.colors.textPrimary
         titleFont = theme.fonts.subhead4
     }
 }
