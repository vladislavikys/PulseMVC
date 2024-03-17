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
    
    private let aboutData = ["Height", "Weight", "Age"]
    
    var userProfile =  AboutModel()
    //замыкание передачи пользователя
    var didEnterData: ((AboutModel) -> Void)?
        
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
        collectionView.register(GenderAboutCell.self, forCellWithReuseIdentifier: "GenderAboutCell")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(190)
            make.centerY.equalTo(view)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(18)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-18)
            make.height.equalTo(360)
        }
        
        view.addSubview(stackUnits)
        stackUnits.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(140)
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
        //uploadUserDefToUserProfile()
        dismiss(animated: true) {
            UIView.animate(withDuration: 0.3) {
                self.view.alpha = 0
            }
        }
    }
}

extension AboutMeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell
        
        if indexPath.item == 0 {
            let genderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenderAboutCell", for: indexPath) as! GenderAboutCell
            cell = genderCell
        } else {
            let aboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutCell", for: indexPath) as! AboutCell
            let name = aboutData[indexPath.item - 1 ]
            aboutCell.titleLabel.text = name
            aboutCell.nameCell = name
            
            cell = aboutCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

extension AboutMeViewController {
//    private func uploadUserDefToUserProfile() {
//        let gender = UserDefaults.standard.string(forKey: "SelectedGender")
//        userProfile.gender = gender
//        let units = UserDefaults.standard.string(forKey: "Units")
//        userProfile.units = units
//        
//        if let age = UserDefaults.standard.string(forKey: "AgePerson") {
//            userProfile.age = Int(age)
//        } else {
//            userProfile.age = nil
//        }
//        if let height = UserDefaults.standard.string(forKey: "HeightPerson") {
//            userProfile.height = Int(height)
//        } else {
//            userProfile.height = nil
//        }
//        if let weight = UserDefaults.standard.string(forKey: "WeightPerson") {
//            userProfile.weight = Int(weight)
//        } else {
//            userProfile.weight = nil
//        }
//        
//        let encoder = JSONEncoder()
//        if let econderUser = try? encoder.encode(userProfile) {
//            UserDefaults.standard.set(econderUser, forKey: "userProfile")
//        } else {
//            print("Ошибка при кодировании данных пользователя")
//        }
//        
//    }
}
