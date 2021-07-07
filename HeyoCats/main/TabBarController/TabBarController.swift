//
//  TabBarController.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 07/07/2021.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCustomTabBarHeight()
    }
    
    private func setupViewControllers() {
        let homeViewController = AllCatsViewController()
        homeViewController.tabBarItem.title = "All Cats"
        homeViewController.tabBarItem.image = UIImage(named: "cat_icon")
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        let favouritesViewController = CatsILikeViewController()
        favouritesViewController.tabBarItem.title = "Cats I Like"
        favouritesViewController.tabBarItem.image = UIImage(named: "heart_tab")
        favouritesViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
        viewControllers = [homeViewController, favouritesViewController ]
    }
    
    private func setCustomTabBarHeight() {
        let tabBarHeight: CGFloat = 120
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
    }
    
    private func setupTabBarView() {
        self.tabBar.tintColor = UIColor(named: "primary_text")
        self.tabBar.unselectedItemTintColor = UIColor(named: "unselected_tab")
        self.tabBar.barTintColor = .white
    }
    
}

