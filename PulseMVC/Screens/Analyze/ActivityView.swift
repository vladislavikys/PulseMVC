//
//  ActivityView.swift
//  PulseMVC
//
//  Created by vlad zarya on 16.03.24.
//

import UIKit
import SnapKit

protocol ActivityViewDelegate: AnyObject {
    func activityViewDidActivate(_ activityView: ActivityView)
}

class ActivityView: UIView {
    
    weak var delegate: ActivityViewDelegate?

    var imageView: UIImageView!
    var isActive: Bool = false {
        didSet {
            updateBorder()
            if isActive {
                delegate?.activityViewDidActivate(self)
            }
        }
    }
    
    var nameEmoji = ""
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView(name: nameEmoji)
        setupTapGesture()
        updateBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView(name: nameEmoji)
        setupTapGesture()
        updateBorder()
    }
    func setImage(named name: String) {
        imageView.image = UIImage(named: name)
    }
    private func setupImageView(name: String) {
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.center.equalToSuperview()
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleActive))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggleActive() {
        isActive = !isActive
//        if isActive {
//            delegate?.activityViewDidActivate(self)
//        }
    }
    
    private func updateBorder() {
        layer.cornerRadius = 30 // Скругление углов
        layer.backgroundColor = AppColor.backAnalyzeView.color.cgColor
        layer.borderWidth = isActive ? 2 : 0.6
        layer.borderColor = isActive ? UIColor.orange.cgColor : UIColor.lightGray.cgColor
        
        imageView.alpha = isActive ? 1.0 : 0.66 // Смена прозрачности иконки
        label?.alpha = isActive ? 1.0 : 0.45// Смена прозрачности текста
    }
}

