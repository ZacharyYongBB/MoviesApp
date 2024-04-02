//
//  TextFieldViewModifier.swift
//  CTQuizMaster
//
//  Created by Zachary on 29/2/24.
//

import Foundation
import SwiftUI

struct TextFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
    }
}

extension View {
    func TextFieldFormat() -> some View {
        modifier(TextFieldViewModifier())
    }
}
