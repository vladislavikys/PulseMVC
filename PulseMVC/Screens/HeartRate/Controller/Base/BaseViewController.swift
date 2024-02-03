//
//  BaseViewController.swift
//  PulseMVC
//
//  Created by Влад on 1.02.24.
//

import UIKit
class BaseViewController: UIViewController {
    
    
    public var backgoundImageView = UIImageView()
    public var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTestText()
        setBackground()
        view.backgroundColor = UIColor.white
    }
    
    
    
    func setBackground(){
        view.addSubview(backgoundImageView)
        view.addSubview(titleLabel)
        backgoundImageView.image = UIImage(named: "backgroundColor")
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "San Francisco", size: 28)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            backgoundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgoundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgoundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgoundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //titleLabel.heightAnchor.constraint(equalToConstant: 33),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        ])
    }
}



extension BaseViewController {
    func addTestText() {
        let testLabel = UILabel()
        testLabel.text = "Base Text"
        testLabel.textAlignment = .center
        testLabel.font = UIFont.systemFont(ofSize: 10)
        testLabel.textColor = .red
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 150),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -310)
        ])
    }
}
