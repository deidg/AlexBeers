//
//  TabBarContoller.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabs()
    }

    private func generateTabs() {
        let beerListVC = UINavigationController(rootViewController: BeerListVC())
        let searchVC = UINavigationController(rootViewController: SearchByIdVC())
        let randomBeerVC = UINavigationController(rootViewController: RandomBeerVC())
        beerListVC.tabBarItem = UITabBarItem(title: "Beer List", image: UIImage(systemName: "1.circle"), tag: 0)
        searchVC.tabBarItem = UITabBarItem(title: "Search ID", image: UIImage(systemName: "2.circle"), tag: 0)
        randomBeerVC.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "3.circle"), tag: 0)
        viewControllers = [beerListVC, searchVC, randomBeerVC]
    }
}
