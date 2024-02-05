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
    private let viewTemplate = ViewTemplate()
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
        setupViewTemplate()
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
        view.addSubview(viewTemplate)
        viewTemplate.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalTo(view.safeAreaLayoutGuide)
        }
        viewTemplate.setupLabels()
    }
    
    private func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func unHideLabels() {
        viewTemplate.descLabel.isHidden = false
        viewTemplate.beerImageView.isHidden = false
        viewTemplate.idLabel.isHidden = false
    }
    
    private func getBeerInfoByID(id: Int) {
        networkingApi.searchBeerById(id: id) { [weak self]  beerResponse in
            guard let self else { return }
            let beer = beerResponse?.first
            unHideLabels()
            DispatchQueue.main.async {
                self.viewTemplate.beerImageView.kf.setImage(with: URL(string: beer?.imageURL ?? ""))
                self.viewTemplate.idLabel.text = String((beer?.id)!)
                //self.idLabel.text = String(beer.id ?? "")
                self.viewTemplate.nameLabel.text = beer?.name ?? ""
                self.viewTemplate.descLabel.text = beer?.description ?? ""
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
        if inputID < 300 {
            getBeerInfoByID(id: inputID)
        } else {
            viewTemplate.nameLabel.text = "ID must be less 300"
            viewTemplate.descLabel.isHidden = true
            viewTemplate.beerImageView.isHidden = true
            viewTemplate.idLabel.isHidden = true
        }
    }
}
