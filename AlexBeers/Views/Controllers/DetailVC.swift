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
    //MARK: - Initialization
    init(beerItem: BeerItem) {
        super.init(nibName: nil, bundle: nil)
        configureView(with: beerItem)
    }
    required init?(coder: NSCoder) {
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupUI()
    }
    // MARK: - Private methods
    private func setupVC() {
        view.backgroundColor = .white
    }
    
    private func setupUI() {
        view.addSubview(beerViewTemplate)
        beerViewTemplate.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureView(with beer: BeerItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            beerViewTemplate.configureView(imageLink: beer.imageURL ?? "",
                                           id: beer.id ?? 0,
                                           name: beer.name ?? "",
                                           description: beer.description ?? "")
        }
    }
}

