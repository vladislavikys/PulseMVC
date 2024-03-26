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
    case status
    
    var color:UIColor{
        switch self{
        case .buttonColor:
            return UIColor(named: "buttonColor") ?? .red
        case .selectedTabBar:
            return UIColor(named: "selectedTabBar") ?? .red
        case .unselectedTabBar:
            return UIColor(named: "unselectedTabBar") ?? .red
        case .tabBarBack:
            return UIColor(named: "tabBarBack") ?? .red
        case .aboutTextColor:
            return UIColor(named: "aboutTextColor") ?? .red
        case .aboutCellBack:
            return UIColor(named: "aboutCellBack") ?? .red
        case .strokeCell:
            return UIColor(named: "strokeCell") ?? .red
        case .backAnalyzeView:
            return UIColor(named: "backAnalyzeView") ?? .red
        case .status:
            return UIColor(named: "status") ?? .red
        }
        

    }
}
