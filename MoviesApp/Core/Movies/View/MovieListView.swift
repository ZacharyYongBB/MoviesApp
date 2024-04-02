//
//  MovieListView.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject private var vm = MovieViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Text("movie list")
            Button {
                Task {
                    do {
                        try vm.logOut()
                        showSignInView = true
                    } catch {
                        print("log out failed \(error)")
                    }
                }
            } label: {
                Text(LocalizedStringKey("logOut"))
            }
        }
    }
}

#Preview {
    MovieListView(showSignInView: .constant(false))
}
