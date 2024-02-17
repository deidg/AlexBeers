//
//  ViewController.swift
//  AlexBeerShop
//
//  Created by Alex on 16.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class BeerListVC: UIViewController {
    // MARK: Elements
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BeerCell.self, forCellReuseIdentifier: "BeerTableViewCell")
        return tableView
    }()
    private var beers: [BeerItem] = []
    private var page = 1
    private let networkingApi: NetworkService!
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
        setupSubview()
        setupNavigationTitle()
        getBeerList()
        setupDelegates()
        addTargets()
    }
    // MARK: Private Methods
    private func setupSubview() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        tableView.addSubview(refreshControl)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupNavigationTitle() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "BeerList"
        self.navigationItem.accessibilityLabel = "BeerList"
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addTargets() {
        refreshControl.addTarget(self, action: #selector(resetView), for: .valueChanged)
    }
    
    private func getBeerList() {
        self.activityIndicator.startAnimating()
        networkingApi.fetchListOfBeers(page: page, completion: { [weak self] beers in
            guard let self else { return }
            self.beers += beers
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        self.activityIndicator.stopAnimating()
    }
    

    
    @objc private func resetView() {
        networkingApi.fetchListOfBeers(page: 1, completion: { [weak self] beers in
            guard let self else { return }
            self.beers = beers
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
    }
}
//MARK: - Extension
extension BeerListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell") as? BeerCell else { return UITableViewCell() }
        cell.setupView(model: beers[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if Int(scrollView.contentOffset.y) >= 1800 * self.page {
            self.page += 1
            self.getBeerList()
        }
    }
}





