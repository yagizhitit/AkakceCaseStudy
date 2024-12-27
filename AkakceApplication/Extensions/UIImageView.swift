//
//  UIImageView.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 26.12.2024.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Geçersiz URL: \(urlString)") // Debug için
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    print("Görsel yüklendi: \(urlString)") // Debug için
                }
            } else {
                print("Görsel yüklenemedi: \(urlString)") // Debug için
            }
        }
    }
}
