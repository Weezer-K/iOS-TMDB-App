//
//  MovieImageIcon.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import SwiftUI

struct MovieIcon: View {
    @StateObject private var viewModel: MovieIconViewModel
    @State private var imageLoaded = false

    init(movie: Movie, _isButtonDisabled: Bool = false) {
        _viewModel = StateObject(wrappedValue: MovieIconViewModel(movie: movie, _isButtonDisabled: _isButtonDisabled))
    }

    var body: some View {
        VStack {
            if let url = viewModel.imageURL {
                CachedAsyncImage(url: url, onLoad: {
                    imageLoaded = true
                })
                .scaledToFill()
                .frame(width: 250, height: 350)
                .clipped()
                .overlay(
                    Group {
                        if imageLoaded && !viewModel.isButtonDisabled {
                            MovieImageOverlay(
                                voteAverage: viewModel.movie.voteAverage,
                                isLiked: viewModel.isLiked,
                                onLikeTapped: viewModel.toggleLike
                            )
                        }
                    }
                )
                .padding(.horizontal, 8)
            }
        }
        .onAppear {
            viewModel.checkIfIsLiked()
        }
    }
}

private struct MovieImageOverlay: View {
    let voteAverage: Double
    let isLiked: Bool
    let onLikeTapped: () -> Void

    var body: some View {
        HStack {
            VoteAverageBadge(score: voteAverage)
                .padding(.leading, 10)
            Spacer()
            LikeButton(isLiked: isLiked, onTap: onLikeTapped)
                .padding(.trailing, 10)
        }
        .padding(.top, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

private struct VoteAverageBadge: View {
    let score: Double

    var body: some View {
        ZStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", score))
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
    }
}

private struct LikeButton: View {
    let isLiked: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .font(.largeTitle)
                .foregroundColor(isLiked ? .red : .gray)
        }
    }
}

