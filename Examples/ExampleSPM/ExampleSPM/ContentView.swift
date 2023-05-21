//
//  ContentView.swift
//  ExampleSPM
//
//  Created by ANpolyakov on 29.06.2021.
//

import SwiftUI
import AdmiralUIKit
import AdmiralSwiftUI
import AdmiralSymbols
import AdmiralUIResources

struct ContentView: View {
    
    @State var text: String? = "Text"
        
    var body: some View {
        VStack() {
            Spacer()
            SwiftUI.Button("SwiftUI", action: {})
                .buttonStyle(PrimaryButtonStyle())
            AdmiralSymbols.AssetSymbol.Category.Solid.acuringFuture.swiftUIImage
            TextView($text, placeholder: "Place", name: "Name")
            StandardTextField(
                $text,
                placeholder: "Placeholder",
                name: "Name")
            WrapedPrimaryButton(text: .constant("UIKit"))
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }.padding(.horizontal)
    }
}

struct WrapedPrimaryButton: UIViewRepresentable {
    @Binding var text: String?

    func makeUIView(context: Context) -> UIButton {
        return AdmiralUIKit.PrimaryButton();
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
