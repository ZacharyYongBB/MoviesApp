//
//  OptionButtonViewModifier.swift
//  CTQuizMaster
//
//  Created by Zachary on 28/2/24.
//

import Foundation
import SwiftUI

struct OptionButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10.0)
            .shadow(radius: 10.0)
            .padding()
    }
}

extension View {
    func optionButtonFormat() -> some View {
        modifier(OptionButtonViewModifier())
    }
}
