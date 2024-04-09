//
//  PayWallCell.swift
//  PulseMVC
//
//  Created by vlad zarya on 9.04.24.
//

import UIKit

class PayWallCell: UICollectionViewCell {
    static let identifier = "PayWallCell"

    private let emojiContainerView = PayWallView()
    private let emojiLabel = UILabel()
    private let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
       
    }

    private func addConstraints() {
        
    }
}
