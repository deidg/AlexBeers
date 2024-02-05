//
//  requestManager.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import Foundation

protocol NetworkService {
    func fetchListOfBeers(page: Int, completion: @escaping ([BeerItem]) -> Void)

    func searchBeerById(id: Int, completion: @escaping ([BeerItem]?) -> Void)
    
    
//    func getRandomBeer(completion: @escaping ([BeerItem]) -> Void)
}

class NetworkRequest: NetworkService {
    //MARK: - Methods
    func fetchListOfBeers(page: Int, completion: @escaping ([BeerItem]) -> Void) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?per_page=25&page=\(page)") else {
            return
        }
        DispatchQueue.global().async {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let beerResponse = try? JSONDecoder().decode([BeerItem].self, from: data)
                    completion(beerResponse ?? [BeerItem]())
                    return
                }
            }
            task.resume()
        }
    }
    
    func searchBeerById(id: Int, completion: @escaping ([BeerItem]?) -> Void) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers/\(id)") else {
            return
        }
        DispatchQueue.global().async {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let beerResponse = try? JSONDecoder().decode([BeerItem].self, from: data)
                    completion(beerResponse)
                    return
                }
            }
            task.resume()
        }
    }
}
