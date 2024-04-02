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
    @State var movies: [MovieModel] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var searchTitle = ""
    @State private var searchTask: Task<Void, Never>?
    
    
    var body: some View {
        VStack {
            List(movies, id: \.imdbID) { movie in
                MovieItemView(movie: movie)
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image(systemName: "gear")
                        .font(.headline)
                    Button {
                        Task {
                            do {
                                try vm.logOut()
                                showSignInView = true
                            } catch {
                                showAlert = true
                                alertMessage = "Log out failed: \(error)"                            }
                        }
                    } label: {
                        Text("Log Out")
                    }
                }
                
            }
        })
        .task {
            movies = await vm.searchMovie(search: "")
        }
        .onChange(of: searchTitle) {
            if !searchTitle.isEmpty {
                searchTask?.cancel()
                searchTask = Task {
                    movies = await vm.searchMovie(search: searchTitle)
                }
            }
        }
        .searchable(text: $searchTitle, placement: .navigationBarDrawer, prompt: "Enter movie name")
    }
}

#Preview {
    MovieListView(showSignInView: .constant(false))
}
