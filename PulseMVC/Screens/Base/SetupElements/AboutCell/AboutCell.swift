//
//  AboutCell.swift
//  PulseMVC
//
//  Created by Влад on 6.02.24.
//

import UIKit

final class AboutCell: UICollectionViewCell{
    
    var titleLabel:UILabel = {
        let label = UILabel()
        //label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    var addButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapper), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        
    }
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configTitleLabel(with title: String){
        self.titleLabel.text = title
    }
    
    func setupCell(){
        backgroundColor = AppColor.aboutCellBack.color.withAlphaComponent(0.6)
        
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = AppColor.strokeCell.color.cgColor
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
        //make.centerX.equalToSuperview().offset(-135)
            make.leading.equalTo(self.snp.leading).offset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(14)
        }
    }
    
    @objc func addButtonTapper(){
        print("Add button tepped ")
    }
}

