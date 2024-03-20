//
//  TabBarController.swift
//  PulseMVC
//
//  Created by Влад on 4.02.24.
//

import UIKit

class TabBarController:UITabBarController{
    
    let heightTabBar: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = heightTabBar
        tabBar.frame.origin.y = view.frame.height - heightTabBar
    }
    
    
    private func setupTabs(){
        let pulseViewController = PulseViewController()
        let history = HistoryViewController()
        let diet = DietViewController()
        let test = TestViewController()
        let profile = ProfileViewController()
        
        // Настроим тайтлы и изображения для каждого таба
        pulseViewController.tabBarItem = UITabBarItem(title: "Pulse", image: UIImage(named: "pulse_icon"), tag: 0)
        history.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history_icon"), tag: 1)
        diet.tabBarItem = UITabBarItem(title: "Diet", image: UIImage(named: "diet_icon"), tag: 2)
        test.tabBarItem = UITabBarItem(title: "Test", image: UIImage(named: "test_icon"), tag: 3)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_icon"), tag: 4)
        
        viewControllers =  [pulseViewController, history, diet, test, profile]
        
        tabBar.tintColor = AppColor.selectedTabBar.color
        tabBar.backgroundColor = AppColor.tabBarBack.color
        tabBar.layer.cornerRadius = 20
        
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        tabBar.standardAppearance = appearance
        
    }
}
