//
//  DetailVC.swift
//  AlexBeerShop
//
//  Created by Alex on 22.01.2024.
//

import UIKit
import SnapKit
import Kingfisher


class DetailVC: UIViewController {
    // MARK: - Elements
    private let beerViewTemplate = BeerViewTemplate()
    private var beerItem: BeerItem?
    
    // Initialize DetailVC with a BeerItem
    init(beerItem: BeerItem) {
        self.beerItem = beerItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupUI()
        gestureRecognize()
    }
    
    // MARK: Private Methods
    private func setupVC() {
        view.backgroundColor = .white
        if let beer = beerItem {
            configureView(with: beer)
        }
    }
    
    private func setupUI() {
        view.addSubview(beerViewTemplate)
        beerViewTemplate.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView(with beer: BeerItem) {
        beerViewTemplate.configureView(imageLink: beer.imageURL ?? "",
                                        id: beer.id ?? 0,
                                        name: beer.name ?? "",
                                        description: beer.description ?? "")
    }
 
    private func gestureRecognize() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeDetailVC))
               view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func closeDetailVC() {
        dismiss(animated: true)
    }
}

