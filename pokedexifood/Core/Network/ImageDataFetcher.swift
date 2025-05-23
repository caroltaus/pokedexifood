//
//  ImageDataFetcher.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import Foundation
import UIKit

protocol ImageDataFetcherProtocol: Actor {
    func requestImage(url: URL) async -> UIImage?
}

final actor ImageDataFetcher: ImageDataFetcherProtocol {
    private let session: NetworkProtocol
    private let cache: NSCache<NSURL, UIImage> = .init()
    static let shared: ImageDataFetcherProtocol = ImageDataFetcher()

    init(session: NetworkProtocol = URLSession.shared) {
        self.session = session
        cache.countLimit = 200
    }

    func requestImage(url: URL) async -> UIImage? {
        if let image = cache.object(forKey: url as NSURL) {
            return image
        }

        do {
            let data = try await session.fetch(for: url)
            let image = UIImage(data: data)
            if let image {
                cache.setObject(image, forKey: url as NSURL)
            }
            return image
        } catch {
            return nil
        }
    }
}
