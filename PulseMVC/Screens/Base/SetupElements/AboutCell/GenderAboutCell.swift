//
//  GenderAboutCell.swift
//  PulseMVC
//
//  Created by Влад on 8.02.24.
//

import UIKit
class  GenderAboutCell: UICollectionViewCell {
    
    var stackButton: CircleButtonHStack!
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell(){
        
        stackButton = CircleButtonHStack()
        backgroundColor = AppColor.aboutCellBack.color.withAlphaComponent(0.6)
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = AppColor.strokeCell.color.cgColor
        titleLabel.text = "Gender"
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            make.centerY.equalToSuperview()
        }
        addSubview(stackButton)
        stackButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-80)
        }
    }
}

    
    
    
    
    
    
    
 

