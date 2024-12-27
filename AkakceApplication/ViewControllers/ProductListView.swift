//
//  ProductListView.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 26.12.2024.
//

import UIKit

class ProductListView: UIView {

    // MARK: - Properties
    private var products: [Product] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 30) / 2, height: 200)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: ProductListCell.identifier)
        return collectionView
    }()

    // MARK: - Initializers
    init(products: [Product]) {
        self.products = products
        super.init(frame: .zero)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func reloadData() {
        collectionView.reloadData() // İçteki UICollectionView'i günceller
    }
    
    func updateProducts(_ newProducts: [Product]) {
            self.products = newProducts
            collectionView.reloadData()
        }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProductListView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}
