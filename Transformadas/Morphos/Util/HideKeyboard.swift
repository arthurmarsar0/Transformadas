//
//  HideKeyboard.swift
//  Transformadas
//
//  Created by Pedro Vitor de Oliveira Monte on 06/11/24.
//
import SwiftUI

struct KeyboardDismiss: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("OK") {
                        hideKeyboard()
                    }
                }
            }
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
