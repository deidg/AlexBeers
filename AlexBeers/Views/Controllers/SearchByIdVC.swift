//
//  SearchVC.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

class SearchByIdVC: UIViewController {
    // MARK: Elements
    private let networkRequest = NetworkRequest()
    private let searchController = UISearchController(searchResultsController: nil)
    private let beers: [BeerItem] = []
    private let beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        return beerImageView
    }()
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        idLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return idLabel
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return nameLabel
    }()
    private let descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.gray
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        return descLabel
    }()
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, descLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .center
        nameStackView.spacing = Constants.nameStackViewstackSpacing
        return nameStackView
    }()
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView(arrangedSubviews: [beerImageView, nameStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = Constants.mainStackViewstackSpacing
        return mainStackView
    }()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        setupVC()
        setupSearchController()
    }
    // MARK: Private Methods
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search by ID"
    }
    
    private func setupVC() {
        view.backgroundColor = .white
    }
    
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupLabels() {
        view.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.trailing.leading.equalToSuperview()
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)

            //safeAreaLayoutGuide
        }
    }
    
    private func getBeerInfoByID(id: Int) {
        networkRequest.searchBeerById(id: id) { [weak self]  beerResponse in
            guard let self else { return }
            let beer = beerResponse?.first
            setupLabels()
            DispatchQueue.main.async {
                self.beerImageView.kf.setImage(with: URL(string: beer?.imageURL ?? ""))
                self.idLabel.text = String((beer?.id)!)
                //self.idLabel.text = String(beer.id ?? "")
                self.nameLabel.text = beer?.name ?? ""
                self.descLabel.text = beer?.description ?? ""
            }
        }
    }
}
// MARK: Constants
extension SearchByIdVC {
    enum Constants {
        static let nameStackViewstackSpacing : CGFloat = 2.0
        static let mainStackViewstackSpacing: CGFloat = 10.0
        static let padding: CGFloat = 16.0
    }
}
//MARK: - Extension
extension SearchByIdVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputID = Int(searchController.searchBar.text ?? "") else { return }
        getBeerInfoByID(id: inputID)
    }
}

