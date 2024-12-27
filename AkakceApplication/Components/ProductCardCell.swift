//
//  ProductCardCell.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 25.12.2024.
//

import UIKit

class ProductCardCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "ProductCardCell"

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true

        // Add subviews
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(ratingCountLabel)
        contentView.addSubview(rate)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil // Görseli sıfırla
        productNameLabel.text = nil // Başlığı sıfırla
        priceLabel.text = nil // Fiyatı sıfırla
        ratingCountLabel.text = nil // Satıcı sayısını sıfırla
        rate.text = nil // Takipçi sayısını sıfırla
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Product Image
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 150),
            productImageView.heightAnchor.constraint(equalToConstant: 150),

            // Product Name Label
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            // Price Label
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),

            // Seller Count Label
            ratingCountLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            ratingCountLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),

            // Follower Count Label
            rate.topAnchor.constraint(equalTo: ratingCountLabel.bottomAnchor, constant: 5),
            rate.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10)
        ])
    }

    // MARK: - Configure Cell
    func configure(with product: Product) {
        print("Ürün adı: \(product.title)") 
        productImageView.loadImage(from: product.image)
        productNameLabel.text = product.title
        priceLabel.text = "\(String(product.price)) TL"
        ratingCountLabel.text = "\(product.rating.count) kişi değerlendirdi"
        rate.text = "★\(product.rating.rate) puan"
        
        productImageView.image = nil
        productImageView.loadImage(from: product.image)
    }
}
