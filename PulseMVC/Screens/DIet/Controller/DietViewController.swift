//
//  DietViewController.swift
//  PulseMVC
//
//  Created by Влад on 3.02.24.
//

import UIKit

class DietViewController: BaseViewController {
    
    let breackfast = HorizontalView()
    let lunch = HorizontalView()
    let dinner = HorizontalView()
    
    
    var horizontalViews : [HorizontalView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        breackfast.titleLabel.text = "Breakfast"
        lunch.titleLabel.text = "Lunch"
        dinner.titleLabel.text = "Dinner"
        
        horizontalViews = [breackfast,lunch,dinner]
        
        for horizontalView in horizontalViews {
            view.addSubview(horizontalView)
            horizontalView.delegate = self
        }
    }
    
    private func setupConstraints() {
        for (index, horizontalView) in horizontalViews.enumerated() {
            horizontalView.snp.makeConstraints { make in
                if index == 0 {
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
                } else {
                    make.top.equalTo(horizontalViews[index - 1].snp.bottom)
                }
                make.left.right.equalToSuperview().inset(-15)
                make.height.equalTo(216)
            }
        }
    }
}

extension DietViewController: HorizontalViewDelegate {
    func didSelectRecipe(at index: Int) {
        let recipeView = RecipeView()
        present(recipeView, animated: true)
    }
}
