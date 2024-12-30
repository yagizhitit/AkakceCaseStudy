//
//  HomeViewController.swift
//  AkakceApplication
//
//  Created by Yağız Hitit on 25.12.2024.
//

import UIKit

class HomeViewController: UIViewController, ProductListViewDelegate {
    
    private var horizontalProducts: [Product] = []
    private var products: [Product] = []
    
    private var productListView: ProductListView = ProductListView(products: [])
    
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
    
    
    // MARK: - Initializer
    init() {
        productListView = ProductListView(products: products)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        productListView.delegate = self
        setUpNavigationBar()
        cardCollectionView.register(ProductCardCell.self, forCellWithReuseIdentifier: ProductCardCell.identifier)
        setupViews()
        
        pageControl.numberOfPages = horizontalProducts.count
        pageControl.currentPage = 0
        
        fetchProducts()
    }
    
    // MARK: - Fetching Methods
    private func fetchProducts() {
        // Horizontal Products
        NetworkManager.shared.fetchHorizontalProducts(limit: 5) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedHorizontalProducts):
                    print("Horizontal Products başarıyla çekildi: \(fetchedHorizontalProducts.count) adet")
                    self?.horizontalProducts = fetchedHorizontalProducts
                    
                    self?.pageControl.numberOfPages = fetchedHorizontalProducts.count
                    self?.pageControl.currentPage = 0
                    
                    self?.cardCollectionView.reloadData() // updating Cardview
                    
                case .failure(let error):
                    print("Horizontal Products alınamadı: \(error)")
                }
            }
        }
        
        // Products List
        NetworkManager.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedProducts):
                    print("Products List başarıyla çekildi: \(fetchedProducts.count) ")
                    self?.products = fetchedProducts
                    self?.productListView.updateProducts(fetchedProducts) // Products List güncelle
                    
                case .failure(let error):
                    print("Products List alınamadı: \(error)")
                }
            }
        }
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
        
        pageControl.numberOfPages = horizontalProducts.count
    }
    
    private func setUpNavigationBar() {
        setupNavigationBar(userInitials: "AZ")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cardCollectionView {
            return horizontalProducts.count // Horizontal Products
        } else {
            return products.count // Products List
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cardCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCardCell.identifier, for: indexPath) as! ProductCardCell
            let product = horizontalProducts[indexPath.row] // Horizontal Products
            cell.configure(with: product)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.identifier, for: indexPath) as! ProductListCell
            let product = products[indexPath.row] // Products List
            cell.configure(with: product)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct: Product
        
        if collectionView == cardCollectionView {
            selectedProduct = horizontalProducts[indexPath.row] // Horizontal Products
        } else {
            selectedProduct = products[indexPath.row] // Products List
        }
        
        // Detailed Page Routing
        let detailVC = ProductDetailViewController()
        detailVC.productId = selectedProduct.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func productListView(_ productListView: ProductListView, didSelectProduct product: Product) {
        // Ürün detay sayfasına yönlendirir
        let detailVC = ProductDetailViewController()
        detailVC.productId = product.id // Tıklanan ürünün ID'sini gönder
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == cardCollectionView else { return }
        
        let pageWidth = scrollView.frame.width
        guard pageWidth > 0 else {
            print("pageWidth sıfır!!!!!!")
            return
        }
        
        let contentOffsetX = scrollView.contentOffset.x
        guard contentOffsetX.isFinite && !contentOffsetX.isNaN else {
            print("contentOffset.x geçersiz!!!!")
            return
        }
        
        let pageIndex = Int((contentOffsetX + pageWidth / 2) / pageWidth)
        pageControl.currentPage = pageIndex
    }
}
