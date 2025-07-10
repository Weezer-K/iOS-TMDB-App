//
//  MovieDetailsView.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject private var viewModel: MovieDetailsViewModel

    init(id: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailsViewModel(id: id))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let movie = viewModel.movie {
                    MovieIcon(movie: movie)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(viewModel.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 8)

                    HStack {
                        if viewModel.runTime > 0 {
                            Text("Runtime: \(viewModel.runTime) min")
                        }
                        if !viewModel.releaseDate.isEmpty {
                            Text("Released: \(viewModel.releaseDate)")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    HStack {
                        if !(viewModel.genres?.isEmpty ?? true) {
                            ForEach(viewModel.genres ?? []) { genre in
                                Text(genre.name ?? "")
                            }
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    if !viewModel.overview.isEmpty {
                        Text("Overview")
                            .font(.headline)
                            .padding(.top, 8)

                        Text(viewModel.overview)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    ProgressView("Loading movie details...")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
