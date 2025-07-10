//
//  CachedImageLoader.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import UIKit
import SwiftUI

@MainActor
public final class CachedImageLoader: ObservableObject {
    @Published public var image: UIImage?

    public init() {}

    public func load(from url: URL) {
        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    ImageCache.shared.setObject(uiImage, forKey: url as NSURL)
                    self.image = uiImage
                }
            } catch {
                self.image = nil
            }
        }
    }
}
