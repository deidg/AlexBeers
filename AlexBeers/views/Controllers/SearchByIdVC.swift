//
//  SearchVC.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import UIKit
import SnapKit
import Kingfisher


//TODO: сделать своими руками все элементы

class SearchByIdVC: UIViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    
    private var beers: [BeerItem] = []
    
    private let beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.backgroundColor = .red
        beerImageView.snp.makeConstraints { make in
            //            make.top.equalTo(navigationItem.snp.)
            //            make.edges.equalToSuperview()
            //            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.width.equalTo(300)
        }
        return beerImageView
    }()
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.backgroundColor = .blue
        idLabel.textColor = UIColor.orange
        idLabel.text = "ID"
        idLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        return idLabel
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .yellow
        nameLabel.textColor = .black
        nameLabel.text = "User Name"
        return nameLabel
    }()
    private let descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.backgroundColor = .cyan
        descLabel.text = "Description"
        descLabel.textColor = UIColor.gray
        descLabel.textColor = .black

        descLabel.numberOfLines = 3
        return descLabel
    }()
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, descLabel])
        nameStackView.axis = .horizontal
        nameStackView.alignment = .top
        return nameStackView
    }()
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView(arrangedSubviews: [beerImageView, nameStackView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = Constants.stackSpacing
        return mainStackView
    }()
    
    
    var networkRequest = NetworkRequest()
    
    //    var searchController = UISearchController(searchResultsController: nil)
    //
    //    private var searchBarIsEmpty: Bool {
    //        guard let text = searchController.searchBar.text else { return false }
    //        return text.isEmpty
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
        
        setupSearchController()
        
        setupVC()
//        setupUI()
    }
    
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Search by ID"
        self.navigationItem.accessibilityLabel = "Search by ID"
    }
    
    private func setupVC() {
        view.backgroundColor = .cyan
        
//                view.addSubview(mainStackView)
//                mainStackView.snp.makeConstraints { make in
//        //            make.top.equalTo(view)
//        //            make.edges.equalToSuperview()
//                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//        
//                    make.trailing.leading.bottom.equalToSuperview()
//                }
//        
        
    }
    
    private func setupLabels() {
                        view.addSubview(mainStackView)
                        mainStackView.snp.makeConstraints { make in
                //            make.top.equalTo(view)
                //            make.edges.equalToSuperview()
                            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        
                            make.trailing.leading.bottom.equalToSuperview()
                        }
        
    }
    
    private func setupSearchController() {
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
    }
    
    private func getBeerInfoByID(id: Int) {
        
        networkRequest.searchBeerById(id: id) { [weak self]  beerResponse in
            guard let self else { return }
            let beer = beerResponse?.first
//            print("api request done")
//            self.setupVC()
            setupLabels()

                //                self.beers += beers ??
                DispatchQueue.main.async {
                    
//                    self.setupVC()
                    
                    
                    self.beerImageView.kf.setImage(with: URL(string: beer?.imageURL ?? ""))
                    self.idLabel.text = String((beer?.id)!)
//                    self.idLabel.text = String(beer.id ?? 0)

                    
                    self.nameLabel.text = beer?.name ?? ""
                    self.descLabel.text = beer?.description ?? ""
            }
        }
        
    }
    
    
}


extension SearchByIdVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //        guard let inputText = searchController.searchBar.text else { return }
        //
        //        print(inputText)
        
        
        guard let inputID = Int(searchController.searchBar.text ?? "") else { return } //0 else { return })
        
        print(inputID)

        
        getBeerInfoByID(id: inputID)
        
        print("api request done")

        
        
        //        networkRequest.searchBeerById(id: text) { [weak self] beers in
        //            guard let self else { return }
        //            self.beers += beers ??
        //            DispatchQueue.main.async {
        //
        //
        //                //                self.tableView.reloadData()
        //            }
        //        }
        //        )
        //        self.activityIndicator.stopAnimating()
        //    }
        
        //    NetworkRequest.shared.fetchMovieData(inputText: text) { [weak self] appleResponse in
        //        self?.fetchData(searchTerm: text)
        //
        //
    }
    
    
}

//}

// MARK: Constants
extension SearchByIdVC {
    enum Constants {
        static let stackSpacing: CGFloat = 10.0
        static let padding: CGFloat = 16.0
    }
}
