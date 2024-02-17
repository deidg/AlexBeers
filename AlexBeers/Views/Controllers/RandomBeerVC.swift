//
//  RandomBeerVC.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

class RandomBeerVC: UIViewController {
    // MARK: - Elements
    private let beerViewTemplate = BeerViewTemplate()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let beers: [BeerItem] = []
    private let networkingApi: NetworkService = NetworkRequest()
    private let randomButton: UIButton = {
        let randomButton = UIButton()
        randomButton.backgroundColor = .orange
        randomButton.setTitle("Random beer search", for: .normal)
        randomButton.isEnabled = true
        //        randomButton.addTarget(self, action: #selector(getRandomBeer), for: .touchUpInside)
        return randomButton
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupUI()
        addtargets()
    }
    // MARK: Private Methods
    private func setupVC() {
        view.backgroundColor = .white
        title = "Random"
    }
    private func setupUI() {
        view.addSubview(beerViewTemplate)
        beerViewTemplate.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(randomButton)
        randomButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(30) 
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(30)
        }
    }
    
    private func addtargets() {
        randomButton.addTarget(self, action: #selector(getRandomBeer), for: .touchUpInside)
    }
    
    @objc private func getRandomBeer() {
        self.activityIndicator.startAnimating()
        networkingApi.getRandomBeer { [weak self]  beerResponse in
            guard let self else { return }
            let beer = beerResponse.first
            beerViewTemplate.configureView(imageLink: String(beer?.imageURL ?? ""),
                                           id: beer?.id ?? 0, name: beer?.name ?? "",
                                           description: beer?.description ?? "")
        }
        self.activityIndicator.stopAnimating()
    }
}
