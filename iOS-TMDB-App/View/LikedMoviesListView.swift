//
//  LikedMoviesListView.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import SwiftUI

struct LikedMoviesListView: View {
    @StateObject private var viewModel: LikedMoviesListViewModel

    init() {
        _viewModel = StateObject(wrappedValue: LikedMoviesListViewModel())
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorited Movies")
                .font(.title2)
                .bold()
                .padding(.leading)
                .padding(.top, 16)

            if !viewModel.movies.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.movies) { movie in
                            HStack(alignment: .center, spacing: 12) {
                                if let posterPath = movie.posterPath {
                                    let urlString = viewModel.basePicUrl + posterPath
                                    if let url = URL(string: urlString) {
                                        CachedAsyncImage(url: url)
                                            .frame(width: 100, height: 150)
                                            .clipped()
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(movie.title)
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(movie.overview)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(4)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.removeMovies(id: movie.id)
                                }) {
                                    Text("X")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.red)
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.red, lineWidth: 1)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            } else {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Image(systemName: "heart.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.6))
                        
                        Text("You don't have any favorites... yet")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            viewModel.getMovies()
        }
        .navigationBarBackButtonHidden(true)
    }
}
