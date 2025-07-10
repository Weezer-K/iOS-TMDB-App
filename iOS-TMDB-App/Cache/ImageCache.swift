//
//  ImageCache.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import UIKit

public final class ImageCache {
    public static let shared = NSCache<NSURL, UIImage>()
}
