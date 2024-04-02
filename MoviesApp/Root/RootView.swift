//
//  RootView.swift
//  CTQuizMaster
//
//  Created by Zachary on 29/2/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                MovieListView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                LogInView(showSignInView: $showSignInView)
            }
        })
    }
}

#Preview {
    RootView()
}
