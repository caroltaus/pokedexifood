//
//  FLAnimatedImage+Gif.swift
//  pokedexifood
//
//  Created by Caroline Taus on 27/03/25.
//
import FLAnimatedImage

extension FLAnimatedImage {
    static func gif(named name: String) -> FLAnimatedImage? {
        if let path = Bundle.main.path(forResource: name, ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            if let gifData = try? Data(contentsOf: url) {
                let animatedImage = FLAnimatedImage(animatedGIFData: gifData)
                return animatedImage
            }
        }
        return nil
    }
}
