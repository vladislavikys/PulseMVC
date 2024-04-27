//
//  BaseRecipeView.swift
//  PulseMVC
//
//  Created by vlad zarya on 25.04.24.
//

import UIKit
import SnapKit

class BaseRecipeView: BaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    let subtitleLabel = UILabel()
    let calorieLabel = UILabel()
    let timeLabel = UILabel()
    let servingLabel = UILabel()
    let nutritionFactsStackView = UIStackView()
    let ingredientTitleLabel = UILabel()
    let ingredientListLabel = UILabel()
    let instructionTitleLabel = UILabel()
    let instructionsListLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        imageView.image = UIImage(named: "eat")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        contentView.addSubview(imageView)
        
        titleLabel.text = "Bacon and Eggs"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        
        
        subtitleLabel.text = "Just four ingredients and a delicious breakfast is ready! So let's get started"
        subtitleLabel.textColor = .black
        subtitleLabel.numberOfLines = 0
        contentView.addSubview(subtitleLabel)
        
        nutritionFactsStackView.axis = .horizontal
        nutritionFactsStackView.distribution = .fillEqually
        nutritionFactsStackView.alignment = .center
        nutritionFactsStackView.spacing = 16
        contentView.addSubview(nutritionFactsStackView)
        
        ingredientTitleLabel.text = "Ingredient list"
        ingredientTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        ingredientTitleLabel.textColor = .black
        contentView.addSubview(ingredientTitleLabel)
        
        
        ingredientListLabel.text = "Chicken egg - 4 pieces\nBacon - 100 g\nSalt - Pinch"
        ingredientListLabel.textColor = .black
        ingredientListLabel.numberOfLines = 0
        contentView.addSubview(ingredientListLabel)
        
        
        instructionTitleLabel.text = "Cooking instructions"
        instructionTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        instructionTitleLabel.textColor = .black
        contentView.addSubview(instructionTitleLabel)
        
    
        instructionsListLabel.text = """
            1. Slice the bacon thinly.
            2. Put bacon in a skillet without oil.
            3. Fry the bacon until crisp on both sides.
            4. Break the eggs. Season with salt and pepper.
            5. Fry until tender.
            """
        instructionsListLabel.textColor = .black
        instructionsListLabel.numberOfLines = 0
        contentView.addSubview(instructionsListLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.right.equalTo(contentView)
            make.height.equalTo(contentView.snp.width).multipliedBy(9.0/16.0) // Aspect ratio for the image
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        nutritionFactsStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
            make.height.equalTo(100) // Adjust height as needed
        }
        
        ingredientTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nutritionFactsStackView.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        ingredientListLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientTitleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        instructionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientListLabel.snp.bottom).offset(20)
            make.left.right.equalTo(contentView).inset(20)
        }
        
        instructionsListLabel.snp.makeConstraints { make in
            make.top.equalTo(instructionTitleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
}
