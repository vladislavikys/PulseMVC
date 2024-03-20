//
//  DimmyView.swift
//  PulseMVC
//
//  Created by Влад on 17.02.24.
//

import UIKit
class DimmyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.45)
    }
}
