//
//  VadimProgressCopyLogic.swift
//  PulseMVC
//
//  Created by vlad zarya on 24.04.24.
//

import UIKit


class VadimProgressCopyLogic:UIView {
    private var mainProgressLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var circleOfProgress = CAShapeLayer()
    private var miniCircleContainerLayer = CAShapeLayer()
    
    public var raduis:CGFloat = 107.0
    public var lineWidth:CGFloat = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupProgressBar(type: true)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupProgressBar(type:Bool) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let circlePath = UIBezierPath(arcCenter: self.center,
                                      radius: raduis ,
                                      startAngle: -.pi / 2,
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        progressLayer.strokeEnd = 0
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 1).cgColor
        
        // track layer
        mainProgressLayer.path = circlePath.cgPath
        mainProgressLayer.fillColor = UIColor.clear.cgColor
        mainProgressLayer.lineCap = .round
        mainProgressLayer.lineWidth = lineWidth
        mainProgressLayer.strokeColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 0.4).cgColor
        
        layer.addSublayer(mainProgressLayer)
        layer.addSublayer(progressLayer)
        
        //circle little
        if type {
            let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY )
            let miniPath = CGPath(ellipseIn: CGRect(x: -5, y: -(frame.width / 2)  - 5, width: 10, height: 10), transform: nil)
            circleOfProgress.path = miniPath
            circleOfProgress.position = circleCenter
            circleOfProgress.fillColor = UIColor.white.cgColor
            
            let miniContainerPath = CGPath(ellipseIn: CGRect(x: -10, y: -(frame.width / 2) - 10, width: 20, height: 20), transform: nil)
            miniCircleContainerLayer.path = miniContainerPath
            miniCircleContainerLayer.position = circleCenter
            miniCircleContainerLayer.fillColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 0.4).cgColor
            layer.addSublayer(miniCircleContainerLayer)
            layer.addSublayer(circleOfProgress)
        }
    }
    
    func animationProgress(duration: TimeInterval) {
        let heartRateAnimation = CABasicAnimation(keyPath: "strokeEnd")
        heartRateAnimation.toValue = 1
        heartRateAnimation.fromValue = 0
        heartRateAnimation.duration = 25
        heartRateAnimation.isRemovedOnCompletion = false
        heartRateAnimation.fillMode = .forwards
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * CGFloat.pi
        animation.duration = duration 
        animation.isRemovedOnCompletion = false
        
        circleOfProgress.speed = 1.0
        progressLayer.speed = 1.0
        
        circleOfProgress.add(animation, forKey: nil)
        progressLayer.add(heartRateAnimation, forKey: "progressAnim")
    }
    func deleteAnimations() {
        circleOfProgress.speed = 0.0
        progressLayer.speed = 0.0
    }
    
}
