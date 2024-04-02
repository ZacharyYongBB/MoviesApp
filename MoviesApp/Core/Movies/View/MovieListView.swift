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
    @State private var searchDebounceTimer: Timer?
    
    
    var body: some View {
        VStack {
            if movies.isEmpty && searchTitle == "" {
                VStack (spacing: 20) {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.system(size: 150))
                    Text("Enter a search term")
                }
                .font(.title)
            } else if movies.isEmpty && !searchTitle.isEmpty {
                VStack (spacing: 20) {
                    Image(systemName: "questionmark.bubble")
                        .font(.system(size: 150))
                    Text("No result, please input at least 3 char or search a valid movie")
                        .padding(.horizontal)
                }
                .font(.title)
            } else {
                List(movies, id: \.imdbID) { movie in
                    NavigationLink(destination: MovieDetailView(movieID: movie.imdbID ?? "")) {
                        MovieItemView(movie: movie)
                    }
                }
            }
        }
        .animation(.easeInOut, value: searchTitle)
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
        .onChange(of: searchTitle) {
            searchDebounceTimer?.invalidate()
            
            searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                if !searchTitle.isEmpty {
                    searchTask?.cancel()
                    searchTask = Task {
                        movies = await vm.searchMovie(search: searchTitle)
                    }
                }
            }
            
        }
        .searchable(text: $searchTitle, placement: .navigationBarDrawer, prompt: "Enter movie name")
        .navigationTitle("Movie App")
        .navigationDestination(for: String.self) { movieId in
            MovieDetailView(movieID: movieId)
        }
    }
}

#Preview {
    MovieListView(showSignInView: .constant(false))
}
