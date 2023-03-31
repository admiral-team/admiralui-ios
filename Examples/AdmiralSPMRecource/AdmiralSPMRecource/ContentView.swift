//
//  ContentView.swift
//  AdmiralSPMRecource
//
//  Created by ADyatkov on 31.03.2023.
//

import SwiftUI
import AdmiralUIKit
import AdmiralSwiftUI
import AdmiralUIResources
import AdmiralTheme

struct ContentView: View {
    var body: some View {
        VStack {
            SwiftUI.Button("SwiftUI Button", action: {})
                .buttonStyle(PrimaryButtonStyle())
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            AdmiralUIResources.AssetSymbol.Category.Solid.acuringFuture.image
            WrapedPrimaryButton(text: .constant("UIKit Button"))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
    }
}

struct WrapedPrimaryButton: UIViewRepresentable {
    @Binding var text: String?

    func makeUIView(context: Context) -> UIButton {
        return AdmiralUIKit.PrimaryButton()
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        uiView.setTitle(text, for: .normal);
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
