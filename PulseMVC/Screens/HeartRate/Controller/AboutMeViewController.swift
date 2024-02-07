//
//  AboutMeViewController.swift
//  PulseMVC
//
//  Created by Влад on 5.02.24.
//

import UIKit
class AboutMeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    private var continueButton = GlobalButton()
    private var collectionView: UICollectionView!
    
    var stackUnits: UnitsStackView!
    
    private let aboutData = ["Gender", "Height", "Weight", "Age"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    private func setupUI() {
        titleLabel.text = "About me"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        stackUnits = UnitsStackView()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AboutCell.self, forCellWithReuseIdentifier: "AboutCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(160)
            make.centerY.equalTo(view)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(18)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-18)
            make.height.equalTo(360)
        }
        view.addSubview(stackUnits)
        stackUnits.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(110)
            
        }
        
        
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-110)
        }
        
    }
    
    @objc func continueTapped() {
           dismiss(animated: true) {
               UIView.animate(withDuration: 0.3) {
                   self.view.alpha = 0
               }
           }
       }
}

extension AboutMeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aboutData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutCell", for: indexPath) as! AboutCell
        cell.titleLabel.text = aboutData[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}


    
   
