//
//  CachedAsyncImage.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import SwiftUI

public struct CachedAsyncImage: View {
    @StateObject private var loader = CachedImageLoader()
    private let url: URL
    private var onLoad: (() -> Void)? = nil

    public init(url: URL, onLoad: (() -> Void)? = nil) {
        self.url = url
        self.onLoad = onLoad
    }

    public var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .onAppear {
                        onLoad?()
                    }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loader.load(from: url)
        }
    }
}
