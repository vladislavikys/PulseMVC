//
//  MyProgressBar.swift
//  PulseMVC
//
//  Created by Влад on 8.03.24.
//

import UIKit
class MyProgressBar: UIView {
    
    private var circleLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                         y: frame.size.height / 2.0),
                                                         radius: 107,
                                                         startAngle: -CGFloat.pi / 2,
                                                         endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
                                                         clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(red: 169.0/255.0, green: 169.0/255.0, blue: 169.0/255.0, alpha: 0.2).cgColor // Фоновый цвет окружности
        circleLayer.lineWidth = 2
        circleLayer.strokeEnd = 1.0
        layer.addSublayer(circleLayer)
        
        progressLayer = CAShapeLayer()
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.3).cgColor // Цвет фиолетового прогресса
        progressLayer.lineWidth = 20
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    func setProgress(to progressConstant: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 2
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = progressConstant
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        progressLayer.strokeEnd = progressConstant
        progressLayer.add(animation, forKey: "animateProgress")
    }
}
   
