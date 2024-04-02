//
//  HomeButtonViewModifier.swift
//  CTQuizMaster
//
//  Created by Zachary on 28/2/24.
//

import Foundation
import SwiftUI

struct HomeButtonViewModifier: ViewModifier {
    
    let btnColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(btnColor)
            .cornerRadius(10.0)
            .shadow(radius: 10.0)
            .padding()
    }
}

extension View {
    func homeButtonFormat(color: Color) -> some View {
        modifier(HomeButtonViewModifier(btnColor: color))
    }
}
