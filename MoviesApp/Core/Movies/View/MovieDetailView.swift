//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var vm = MovieDetailsViewModel()
    let movieID: String
    @State private var movie: MovieDetailModel?
    @State private var error: Error?
    
    var body: some View {
        VStack {
            if let movie = movie {
                movieDetailSection
            } else if let error = error {
                Text("Error: \(error.localizedDescription)")
            } else {
                ProgressView()
            }
        }
        .task {
            do {
                self.movie = try await vm.searchMovieId(movieID: movieID)
            } catch {
                self.error = error
            }
        }
    }
}

#Preview {
    MovieDetailView(movieID: "tt4154664")
}

extension MovieDetailView {
    private var movieDetailSection: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PosterImageView(urlString: movie?.poster)
                    .frame(maxWidth: .infinity)
                
                Text(movie?.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Year: \(movie?.year ?? "")")
                
                Text("Rated: \(movie?.rated ?? "")")
                
                Text("Released: \(movie?.released ?? "")")
                
                Text("Runtime: \(movie?.runtime ?? "")")
                
                Text("Genre: \(movie?.genre ?? "")")
                
                Text("Director: \(movie?.director ?? "")")
                
                Text("Writer: \(movie?.writer ?? "")")
                
                Text("Actors: \(movie?.actors ?? "")")
                
                Text("Plot: \(movie?.plot ?? "")")
                    .padding(.bottom)
                
                HStack {
                    RatingView(rating: movie?.imdbRating ?? "")
                    Spacer()
                    Text("IMDb Rating: \(movie?.imdbRating ?? "")")
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
}
