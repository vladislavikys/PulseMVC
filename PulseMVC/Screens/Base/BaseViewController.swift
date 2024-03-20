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
    public var activityDescriptionLabel = UILabel()
    
    let testLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        view.backgroundColor = UIColor.white
    }
    
}



extension BaseViewController {
    //справа тестовой для того чтобы видеть изминение экрана
    func addTestText(text: String = "base" ) {
        testLabel.text = text
        testLabel.textAlignment = .center
        testLabel.font = UIFont.systemFont(ofSize: 10)
        testLabel.textColor = .black
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testLabel)
        
        testLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view).offset(160)
            make.centerY.equalTo(view).offset(-300)
        }
    }
    //добавляем фон на экран
    func setBackground(){
        view.addSubview(backgoundImageView)
        view.addSubview(titleLabel)
        view.addSubview(activityDescriptionLabel)
        backgoundImageView.image = UIImage(named: "backgroundColor")
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        
        activityDescriptionLabel.text = "Place your finger on the back camera and flashlight"
        activityDescriptionLabel.numberOfLines = 0
        activityDescriptionLabel.lineBreakMode = .byWordWrapping
        activityDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        activityDescriptionLabel.textAlignment = .center
        
        backgoundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-18)
            make.top.equalTo(view).offset(74)
        }
        
        activityDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(400)
            make.width.equalTo(280)
            make.centerX.equalTo(view)
        }
        
        activityDescriptionLabel.isHidden = true
    }
}
