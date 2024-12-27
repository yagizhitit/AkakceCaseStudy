//
//  ProductListCell.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 26.12.2024.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "ProductListCell"

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemBlue
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let rate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil // Görseli sıfırla
        nameLabel.text = nil // Başlığı sıfırla
        priceLabel.text = nil // Fiyatı sıfırla
        ratingCountLabel.text = nil // Satıcı sayısını sıfırla
        rate.text = nil // Takipçi sayısını sıfırla
    }

    // MARK: - Setup Views
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.shadowColor = UIColor.systemGray.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false

        let stackView = UIStackView(arrangedSubviews: [productImageView, nameLabel, priceLabel, ratingCountLabel, rate])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Configure Cell
    func configure(with product: Product) {
        print("Ürün adı: \(product.title)") 
        productImageView.loadImage(from: product.image)
        nameLabel.text = product.title
        priceLabel.text = "\(String(product.price)) TL"
        ratingCountLabel.text = "\(product.rating.count) kişi değerlendirdi"
        rate.text = "★\(product.rating.rate) puan"
        
        productImageView.image = nil
        productImageView.loadImage(from: product.image)
    }
}
