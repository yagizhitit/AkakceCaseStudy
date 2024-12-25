//
//  HomeViewController.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 25.12.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let products: [Product] = [
            Product(name: "iPhone 13 128 GB", price: "20.567.00 TL", sellerCount: "131 satıcı >", followerCount: "3.000+ takip", imageName: "iphone13_image"),
            Product(name: "Samsung Galaxy S23", price: "25.499.00 TL", sellerCount: "120 satıcı >", followerCount: "4.500+ takip", imageName: "iphone13_image"),
            Product(name: "Xiaomi Mi 12", price: "18.299.00 TL", sellerCount: "98 satıcı >", followerCount: "2.800+ takip", imageName: "iphone13_image"),
            Product(name: "OnePlus 11", price: "22.999.00 TL", sellerCount: "85 satıcı >", followerCount: "3.200+ takip", imageName: "iphone13_image")
        ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width * 0.93, height: 150)
        layout.minimumLineSpacing = 11
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
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
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpNavigationBar()
        setUpCollectionView()
        setupPageControl()
        
    }
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = products.count
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpNavigationBar() {
        
        // Menü butonu (3 çizgi)
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: nil, action: nil)
        menuButton.tintColor = .label
        
        // Akakçe Logo
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "akakceLogo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        navigationItem.titleView = logoImageView
        
        
        
        // Kullanıcı butonu
        let userButton = UIButton(type: .system)
        userButton.setTitle("YH", for: .normal)
        userButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        userButton.setTitleColor(.white, for: .normal)
        userButton.backgroundColor = .black
        userButton.layer.cornerRadius = 18
        userButton.clipsToBounds = true
        userButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        
        let userBarButtton = UIBarButtonItem(customView: userButton)
        
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItem = userBarButtton
        
    
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCardCell.identifier, for: indexPath) as! ProductCardCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width != 0 else {
            print("scrollView.frame.width is zero")
            return
        }

        guard scrollView.contentOffset.x.isFinite, !scrollView.contentOffset.x.isNaN else {
            print("Warning: Invalid scrollView.contentOffset.x value")
            return
        }
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = pageIndex
        }
}
