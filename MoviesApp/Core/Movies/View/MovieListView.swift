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
    @State var movies: [MovieModel]?
    
    var body: some View {
        VStack {
            Text("movie list")
            if let movies = movies {
                ForEach(movies, id: \.imdbID) { movie in
                    Text(movie.title ?? "Unknown Title")
                }
            } else {
                Text("No movies found")
            }
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
                Text("logOut")
            }
            Button {
                Task {
                    movies = await vm.searchMovie(search: "marvel")
                }
            } label: {
                Text("download marvel")
            }
            
        }
    }
}

#Preview {
    MovieListView(showSignInView: .constant(false))
}
