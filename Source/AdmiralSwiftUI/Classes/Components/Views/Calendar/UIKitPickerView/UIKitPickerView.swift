//
//  PickerView.swift
//  AdmiralSwiftUI
//
//  Created on 14.07.2021.
//

import AdmiralUIResources
import AdmiralTheme
import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct UIKitPickerView: UIViewRepresentable {
    
    // MARK: - Internal Properties
    
    var data: [[String]]
    @Binding var selections: [Int]
    
    var textColor: UIColor
    var heightPicker: CGFloat = LayoutGrid.doubleModule * 14
    var widthPicker: CGFloat

    
    // MARK: - Internal Methods

    func makeCoordinator() -> UIKitPickerView.Coordinator {
        Coordinator(data: data, selections: $selections, textColor: textColor)
    }

    func makeUIView(context: UIViewRepresentableContext<UIKitPickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.heightAnchor.constraint(equalToConstant: heightPicker),
            picker.widthAnchor.constraint(equalToConstant: widthPicker)
        ])
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<UIKitPickerView>) {
        context.coordinator.textColor = textColor
        context.coordinator.data = data
        view.reloadAllComponents()
        
        for i in 0...(self.selections.count - 1) {
            view.selectRow(self.selections[i], inComponent: i, animated: false)
        }
    }
    
    // MARK: - Coordinator

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var data: [[String]]
        @Binding var selections: [Int]
        var textColor: UIColor

        init(data: [[String]], selections: Binding<[Int]>, textColor: UIColor) {
            self.data = data
            self._selections = selections
            self.textColor = textColor
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return data.count
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return data[component].count
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selections[component] = row
        }
        
        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            let text = data[component][row]
            return NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : textColor])
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent: Int) -> CGFloat {
            return LayoutGrid.halfModule * 9
        }
    }
}
