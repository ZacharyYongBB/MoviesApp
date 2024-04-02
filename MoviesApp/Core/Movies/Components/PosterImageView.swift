//
//  PosterImageView.swift
//  MoviesApp
//
//  Created by Zachary on 3/4/24.
//

import SwiftUI

struct PosterImageView: View {
    let urlString: String?
    
    var body: some View {
        if let urlString = urlString, let url = URL(string: urlString) {
            AsyncImage(url: url)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    PosterImageView(urlString: "")
}
