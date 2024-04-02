//
//  RatingView.swift
//  MoviesApp
//
//  Created by Zachary on 3/4/24.
//

import SwiftUI

struct RatingView: View {
    let rating: String?
    
    var body: some View {
        if let rating = rating, let doubleRating = Double(rating) {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", doubleRating))
            }
        } else {
            Text("Rating: N/A")
        }
    }
}

#Preview {
    RatingView(rating: "4")
}
