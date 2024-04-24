//
//  AboutMeViewController.swift
//  PulseMVC
//
//  Created by Влад on 5.02.24.
//

import UIKit
protocol AboutMeViewControllerDelegate: AnyObject {
    func didCloseAboutScreen()
}

final class AboutMeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    weak var delegate: AboutMeViewControllerDelegate?
    
    private var continueButton:GlobalButton!
    private var collectionView: UICollectionView!
    private var stackUnits: UnitsStackView!
    
    private let aboutData = ["Height", "Weight", "Age"]
    
    var userProfile =  AboutModel()
    //замыкание передачи пользователя
    var didEnterData: ((AboutModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    private func setupUI() {
        titleLabel.text = "About me"
        stackUnits = UnitsStackView()
        continueButton = GlobalButton()
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(AboutCell.self, forCellWithReuseIdentifier: "AboutCell")
        collectionView.register(GenderAboutCell.self, forCellWithReuseIdentifier: "GenderAboutCell")
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        view.addSubview(stackUnits)
        view.addSubview(continueButton)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackUnits.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(18)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-18)
            make.bottom.equalTo(continueButton.snp.top)
        }
        
        stackUnits.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.top).offset(140)
            make.height.equalTo(30)
        }
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-110)
        }
    }
    
    @objc func continueTapped() {
        // Проверяем, все ли данные заполнены
        // Перебор всех  ячеек = AboutCell
        for case let aboutCell as AboutCell in collectionView.visibleCells {
            //проверка ксли нет данных показываем красный текст
            aboutCell.checkTextFieldAndShowWarningIfNeeded()
        }
        
        guard userProfile.isComplete else {
            return
        }
        
        // Если все данные заполнены, закрываем экран
        UserDefaults.standard.set(true, forKey: "returnedFromAbout")
        dismiss(animated: true) {
            UIView.animate(withDuration: 0.3) {
                self.view.alpha = 0
            }
            self.delegate?.didCloseAboutScreen()
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
            
            //прошлось дописать иначе алерт все равно показывался даже если данные ввели
            //  valueChangeHandler для обновления userProfile
            aboutCell.valueChangeHandler = { [weak self] newValue in
                guard let intValue = Int(newValue) else { return }
                switch name {
                case "Height":
                    self?.userProfile.height = intValue
                case "Weight":
                    self?.userProfile.weight = intValue
                case "Age":
                    self?.userProfile.age = intValue
                default: break
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

