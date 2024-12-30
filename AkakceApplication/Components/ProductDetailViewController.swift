//
//  ProductDetailViewController.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 27.12.2024.
//

import UIKit

class ProductDetailViewController: UIViewController {
    private let categoryLabel = UILabel()
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let ratingLabel = UILabel()
    private let ratingCountLabel = UILabel()
    private let descriptionTitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    var productId: Int? // Tıklanan ürünün IDsi
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        if let productId = productId {
            fetchProductDetails(for: productId)
        }
    }
    
    private func setupUI() {
        // Category
        categoryLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        categoryLabel.textColor = .darkGray
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryLabel)
        
        // Image
        productImageView.contentMode = .scaleAspectFit
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productImageView)
        
        // Title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Price
        priceLabel.font = UIFont.boldSystemFont(ofSize: 24)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        // Rating Stack
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 4
        ratingStackView.alignment = .center
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingStackView)
        
        // Rating
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textColor = .darkGray
        ratingStackView.addArrangedSubview(ratingLabel)
        
        // Stars
        for _ in 1...5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star"))
            starImageView.tintColor = .lightGray
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            starImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            ratingStackView.addArrangedSubview(starImageView)
        }
        
        // Count
        ratingCountLabel.font = UIFont.systemFont(ofSize: 12)
        ratingCountLabel.textColor = .gray
        ratingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingCountLabel)
        
        // Description Title
        descriptionTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descriptionTitleLabel.text = "Açıklama:"
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTitleLabel)
        
        // Description
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        // Auto Layout
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            productImageView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 18),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            ratingStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 18),
            ratingStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ratingCountLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 5),
            ratingCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: ratingCountLabel.bottomAnchor, constant: 20),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func fetchProductDetails(for productId: Int) {
        let urlString = "https://fakestoreapi.com/products/\(productId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                DispatchQueue.main.async {
                    self?.updateUI(with: product)
                    print(urlString)
                }
            } catch {
                print("Ürün detayları alınamadı: \(error)")
            }
        }.resume()
    }
    
    private func updateUI(with product: Product) {
        categoryLabel.text = "\(product.category.capitalized) >"
        productImageView.loadImage(from: product.image)
        titleLabel.text = product.title
        priceLabel.text = "\(product.price) TL"
        ratingLabel.text = String(format: "%.1f", product.rating.rate)
        ratingCountLabel.text = "\(product.rating.count) değerlendirme"
        descriptionLabel.text = product.description
        
        // Filling the stars 
        for (index, view) in ratingStackView.arrangedSubviews.enumerated() {
            if let starImageView = view as? UIImageView {
                starImageView.tintColor = index <= Int(product.rating.rate.rounded()) ? .systemYellow : .lightGray
            }
        }
    }
}
