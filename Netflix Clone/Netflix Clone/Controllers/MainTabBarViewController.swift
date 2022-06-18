//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 18/06/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .gray
        
        let homevc = UINavigationController(rootViewController: HomeViewController())
        let upcomingvc = UINavigationController(rootViewController: UpcomingViewController())
        let searchvc = UINavigationController(rootViewController: SearchViewController())
        let downloadsvc = UINavigationController(rootViewController: DownloadsViewController())
        
        homevc.tabBarItem.image = UIImage(systemName: "house")
        upcomingvc.tabBarItem.image = UIImage(systemName: "play.circle")
        searchvc.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsvc.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homevc.title = "Home"
        upcomingvc.title = "Upcoming"
        searchvc.title = "Search"
        downloadsvc.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([homevc, upcomingvc, searchvc, downloadsvc], animated: true)
        
    }


}

