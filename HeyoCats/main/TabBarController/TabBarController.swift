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
        let insects = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let homeViewController = AllCatsViewController(viewModel: AllCatsViewModel(webService: AllCatsWebService()))
        homeViewController.tabBarItem.title = "All Cats"
        homeViewController.tabBarItem.image = UIImage(named: "cat_icon")
        homeViewController.tabBarItem.imageInsets = insects
        
        let favouritesViewController = CatsILikeViewController()
        favouritesViewController.tabBarItem.title = "Cats I Like"
        favouritesViewController.tabBarItem.image = UIImage(named: "heart_tab")
        favouritesViewController.tabBarItem.imageInsets = insects
    
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
        configureTabBarFontWith(size: 13)
    }
    
    private func configureTabBarFontWith(size: CGFloat) {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: size)], for: .selected)
    }
    
}

