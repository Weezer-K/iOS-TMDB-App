//
//  MoviesView.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var viewModel = MoviesViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                headerView
                movieScrollView
            }
            .onAppear {
                if viewModel.movieList.isEmpty {
                    viewModel.getMovies()
                }
            }
            .padding(.horizontal, 12)

            if let message = viewModel.errorMessage {
                ErrorOverlay(message: message) {
                    viewModel.errorMessage = nil
                    viewModel.getMovies()
                }
            }
        }
    }

    private var headerView: some View {
        HStack(spacing: 10) {
            Text("Most Popular \(viewModel.mostPopularString)")
            Spacer()
            HStack(spacing: 16) {
                Button(action: viewModel.dayPressed) {
                    Text("Day")
                }
                .buttonStyle(.bordered)
                .foregroundColor(viewModel.isDay ? .gray : .blue)
                .opacity(viewModel.isDay ? 0.5 : 1.0)

                Button(action: viewModel.weekPressed) {
                    Text("Week")
                }
                .buttonStyle(.bordered)
                .foregroundColor(!viewModel.isDay ? .gray : .blue)
                .opacity(!viewModel.isDay ? 0.5 : 1.0)
            }
        }
        .padding(.top, 60)
    }

    private var movieScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(viewModel.movieList) { movie in
                    NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                        VStack(spacing: 0) {
                            MovieIcon(movie: movie)
                                .frame(width: 250, height: 350)
                            Text(movie.title)
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(width: 250)
                                .multilineTextAlignment(.center)
                                .padding(.top, 8)
                        }
                    }
                }
                if viewModel.movieList.count > 10 && !viewModel.noMorePages {
                    VStack {
                        Spacer()
                        ProgressView()
                            .onAppear(perform: viewModel.getMovies)
                        Spacer()
                    }
                    .frame(width: 250, height: 350)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal)
        }
        .padding(.top, 20)
    }
}

struct ErrorOverlay: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(message)
                .multilineTextAlignment(.center)
                .padding()

            Button("Retry", action: onRetry)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
}
