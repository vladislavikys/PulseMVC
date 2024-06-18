//
//  DietViewController.swift
//  PulseMVC
//
//  Created by Влад on 3.02.24.
//

import UIKit

class DietViewController: BaseViewController, VerticalViewSeeAllDelegate {
    
    
    
    let breackfast = HorizontalView()
    let lunch = HorizontalView()
    let dinner = HorizontalView()
    
    
    var horizontalViews : [HorizontalView] = []
    var verticalView = VerticalViewSeeAll()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        breackfast.titleLabel.text = "Завтрак"
        lunch.titleLabel.text = "Обед"
        dinner.titleLabel.text = "Ужин"
        
        horizontalViews = [breackfast,lunch,dinner]
        
        for (index, horizontalView)  in horizontalViews.enumerated() {
            view.addSubview(horizontalView)
            horizontalView.tag = index + 1
            horizontalView.delegate = self
        }
        
        verticalView.delegate = self
        verticalView.isHidden = true
        view.addSubview(verticalView)
    }

    
    private func setupConstraints() {
        for (index, horizontalView) in horizontalViews.enumerated() {   // пеербираем массив всех горищонтальных вью
            horizontalView.snp.makeConstraints { make in
                if index == 0 {  // если это первое то привязка с сэйф ареа
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
                } else { // приявязывается к нижнему краю предыдушего вью
                    make.top.equalTo(horizontalViews[index - 1].snp.bottom)
                }
                make.left.right.equalToSuperview().inset(-15) // левый и правый края приявязка
                make.height.equalTo(216)
            }
        }
        
        verticalView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DietViewController: HorizontalViewDelegate {
    
    func didSelectRecipe(at index: Int) {
        let recipeView = RecipeView()
        present(recipeView, animated: true)
    }
    
    func didHideAllHorizViewShowVert(from horizontalView: HorizontalView) {
        horizontalViews.forEach{ $0.isHidden = true }
        verticalView.isHidden = false
        
        switch horizontalView.tag {
        case 1 :
            verticalView.setTitle("Завтрак")
        case 2 :
            verticalView.setTitle("Обед")
        case 3 :
            verticalView.setTitle("Ужин")
        default:
            verticalView.setTitle("Рецепты")
        }
    }
    
    func didTapBack() {
        verticalView.isHidden = true
        horizontalViews.forEach {
            $0.isHidden = false
        }
    }
}

