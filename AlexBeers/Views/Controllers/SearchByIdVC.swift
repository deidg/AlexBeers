//
//  SearchVC.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchByIdVC: UIViewController {
    // MARK: Elements
    private let networkingApi: NetworkService!
    private let searchController = UISearchController(searchResultsController: nil)
    private let beers: [BeerItem] = []
    private let beerViewTemplate = BeerViewTemplate()
    private let onboardLabel: UILabel = {
        let onboardLabel = UILabel()
        onboardLabel.text = "Enter beer ID (max 300)"
        return onboardLabel
    }()
    
    // MARK: Initialization
    init(networkingApi: NetworkService = NetworkRequest()) {
        self.networkingApi = networkingApi
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        return nil
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        setupVC()
        setupOnboardLabel()
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
    
    private func setupViewTemplate() {
        view.addSubview(beerViewTemplate)
        beerViewTemplate.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupOnboardLabel() {
        view.addSubview(onboardLabel)
        onboardLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.keyboardType = .numberPad
    }
 
    private func getBeerInfoByID(id: Int) {
        networkingApi.searchBeerById(id: id) { [weak self]  beerResponse in
            guard let self else { return }
            let beer = beerResponse?.first
            beerViewTemplate.configureView(imageLink: String(beer?.imageURL ?? ""),
                                           id: beer?.id ?? 0, name: beer?.name ?? "",
                                           description: beer?.description ?? "")
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
        if inputID < 300 {
            onboardLabel.isHidden = true
            beerViewTemplate.isHidden = false
            setupViewTemplate()
            getBeerInfoByID(id: inputID)
        } else {
            beerViewTemplate.isHidden = true
            onboardLabel.isHidden = false
        }
    }
}
