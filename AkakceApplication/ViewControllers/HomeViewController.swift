//
//  HomeViewController.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 25.12.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let products: [Product] = [
        Product(name: "iPhone 13 128 GB", price: "20.567.00 TL", sellerCount: "131 satıcı >", followerCount: "3.000+ takip", imageName: "iphone13_image"),
        Product(name: "Samsung Galaxy S23", price: "25.499.00 TL", sellerCount: "120 satıcı >", followerCount: "4.500+ takip", imageName: "iphone13_image"),
        Product(name: "Xiaomi Mi 12", price: "18.299.00 TL", sellerCount: "98 satıcı >", followerCount: "2.800+ takip", imageName: "iphone13_image"),
        Product(name: "OnePlus 11", price: "22.999.00 TL", sellerCount: "85 satıcı >", followerCount: "3.200+ takip", imageName: "iphone13_image")
    ]
    
    private lazy var cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 150)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.shadowColor = UIColor.systemGray.cgColor
        collectionView.layer.shadowOpacity = 0.2
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        collectionView.layer.shadowRadius = 4
        collectionView.layer.masksToBounds = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(ProductCardCell.self, forCellWithReuseIdentifier: ProductCardCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }()
    
    private let productListView: ProductListView
    
    // MARK: - Initializer
    init() {
        productListView = ProductListView(products: products)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpNavigationBar()
        setupViews()
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        view.addSubview(cardCollectionView)
        view.addSubview(pageControl)
        view.addSubview(productListView)
        
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        productListView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Card Collection View
            cardCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            // Page Control
            pageControl.topAnchor.constraint(equalTo: cardCollectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            
            // Product List View
            productListView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            productListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            productListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        pageControl.numberOfPages = products.count
    }
    
    private func setUpNavigationBar() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: nil, action: nil)
        menuButton.tintColor = .label
        
        let logoImageView = UIImageView(image: UIImage(named: "akakceLogo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        navigationItem.titleView = logoImageView
        
        let userButton = UIButton(type: .system)
        userButton.setTitle("YH", for: .normal)
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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCardCell.identifier, for: indexPath) as? ProductCardCell else {
            fatalError("Unable to dequeue ProductCardCell")
        }
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0 else { return }
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
    }
}
