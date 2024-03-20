//
//  AppColor.swift
//  PulseMVC
//
//  Created by Влад on 4.02.24.
//

import UIKit

enum AppColor{
    case buttonColor
    case selectedTabBar
    case unselectedTabBar
    case tabBarBack
    case aboutTextColor
    case aboutCellBack
    case strokeCell
    case backAnalyzeView
    
    var color:UIColor{
        switch self{
        case .buttonColor:
            return UIColor(named: "buttonColor")!
        case .selectedTabBar:
            return UIColor(named: "selectedTabBar")!
        case .unselectedTabBar:
            return UIColor(named: "unselectedTabBar")!
        case .tabBarBack:
            return UIColor(named: "tabBarBack")!
        case .aboutTextColor:
            return UIColor(named: "aboutTextColor")!
        case .aboutCellBack:
            return UIColor(named: "aboutCellBack")!
        case .strokeCell:
            return UIColor(named: "strokeCell")!
        case .backAnalyzeView:
            return UIColor(named: "backAnalyzeView")!
        }
    
        
    }
}
