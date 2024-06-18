//
//  Cell.swift
//  PulseMVC
//
//  Created by vlad zarya on 27.04.24.
//

import UIKit

class Cell: UICollectionViewCell {
    
    let nameLabel = UILabel()
    let recipeImageView = UIImageView()
    let caloriesLabel = UILabel()
    let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(recipeImageView)
        contentView.addSubview(caloriesLabel)
        contentView.addSubview(timeLabel)
        
        recipeImageView.contentMode = .scaleToFill
        
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        caloriesLabel.textColor = .black
        timeLabel.textColor = .black
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        caloriesLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .light)
    }
    
    private func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView)
            make.trailing.equalTo(contentView)
            make.height.equalTo(90)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(8)
            make.trailing.equalTo(contentView).offset(8)
        }
        
        caloriesLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView).offset(12)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.trailing.equalTo(contentView).offset(-12)
        }
    }
}
