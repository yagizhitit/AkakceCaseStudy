//
//  UIImageView.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 26.12.2024.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func loadImage(from urlString: String) {
        // Eğer görsel önbellekte varsa, doğrudan kullanır
        if let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // Görsel önbellekte yoksa, indirir
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Görseli önbelleğe eklemek için
                    ImageCache.shared.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }
    }
}
