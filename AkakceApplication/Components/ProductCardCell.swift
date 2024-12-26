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

    private let sellerCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let followerCountLabel: UILabel = {
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
        contentView.addSubview(sellerCountLabel)
        contentView.addSubview(followerCountLabel)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            sellerCountLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            sellerCountLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),

            // Follower Count Label
            followerCountLabel.topAnchor.constraint(equalTo: sellerCountLabel.bottomAnchor, constant: 5),
            followerCountLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10)
        ])
    }

    // MARK: - Configure Cell
    func configure(with product: Product) {
        productNameLabel.text = product.name
        priceLabel.text = product.price
        sellerCountLabel.text = product.sellerCount
        followerCountLabel.text = product.followerCount
        productImageView.image = UIImage(named: product.imageName)
    }
}
