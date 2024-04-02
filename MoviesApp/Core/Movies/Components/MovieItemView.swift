//
//  MovieItemView.swift
//  MoviesApp
//
//  Created by Zachary on 2/4/24.
//

import SwiftUI

struct MovieItemView: View {
    
    var movie: MovieModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.poster ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
                    .padding(.horizontal)
            } placeholder: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 150)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Text("No poster 🥵")
                        .font(.caption)
                }
                
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(movie.type ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.year ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
        }
        .padding()
        .frame(width: 400, height: 200, alignment: .leading)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

#Preview {
    MovieItemView(movie: MovieModel(title: "123", year: "123", imdbID: "123", type: "123", poster: "123"))
}
