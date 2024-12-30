//
//  UICustomBar.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 30.12.2024.
//

import UIKit

extension UIViewController {
    func setupNavigationBar(title: String? = nil, menuImage: UIImage? = UIImage(systemName: "line.horizontal.3"), userInitials: String? = nil) {
        // Menü butonu
        let menuButton = UIBarButtonItem(image: menuImage, style: .plain, target: nil, action: nil)
        menuButton.tintColor = .label
        
        // Logo
        let logoImageView = UIImageView(image: UIImage(named: "akakceLogo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        navigationItem.titleView = logoImageView
        
        // Kullanıcı butonu
        let userButton = UIButton(type: .system)
        userButton.setTitle(userInitials ?? "?", for: .normal)
        userButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        userButton.setTitleColor(.white, for: .normal)
        userButton.backgroundColor = .black
        userButton.layer.cornerRadius = 18
        userButton.clipsToBounds = true
        userButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userButton)
        navigationItem.leftBarButtonItem = menuButton
    }
}
