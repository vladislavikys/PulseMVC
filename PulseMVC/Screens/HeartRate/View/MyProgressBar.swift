//
//  MyProgressBar.swift
//  PulseMVC
//
//  Created by Влад on 8.03.24.
//
import UIKit

class MyProgressBar: UIView {
    
    let radius: CGFloat = 107
    let lineWidthCircle: CGFloat = 20
    
    private var staticProgressLayer = CAShapeLayer()
    private var animatedProgressLayer = CAShapeLayer()
    
    private var circleOfProgress = CAShapeLayer() // Слой для мини-круга
    private var miniCircleContainerLayer = CAShapeLayer() // Слой для контейнера мини-круга
    
    var circlePath: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCirclePath()
        setupStaticProgressLayer()
        setupAnimatedProgressLayer()
        //setupStartPointLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCirclePath() {
        circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
    }
    
    private func setupStaticProgressLayer() {
        staticProgressLayer.path = circlePath.cgPath
        staticProgressLayer.fillColor = UIColor.clear.cgColor
        staticProgressLayer.lineWidth = lineWidthCircle
        staticProgressLayer.strokeEnd = 1
        staticProgressLayer.strokeColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.4).cgColor
        layer.addSublayer(staticProgressLayer)
    }
    
    private func setupAnimatedProgressLayer() {
        animatedProgressLayer.path = circlePath.cgPath
        animatedProgressLayer.fillColor = UIColor.clear.cgColor
        animatedProgressLayer.lineWidth = lineWidthCircle
        animatedProgressLayer.lineCap = .round
        animatedProgressLayer.strokeEnd = 0
        animatedProgressLayer.strokeColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1).cgColor
        layer.addSublayer(animatedProgressLayer)
    }
    
//    private func setupStartPointLayer() {
//        // Установка положения и формы для мини-круга
//        let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
//        let miniPath = CGPath(ellipseIn: CGRect(x: -5, y: -(frame.width / 2) - 5, width: 10, height: 10), transform: nil)
//        circleOfProgress.path = miniPath
//        circleOfProgress.position = circleCenter
//        circleOfProgress.fillColor = UIColor.white.cgColor
//        
//        // Создание и добавление слоя для контейнера мини-круга
//        let miniContainerPath = CGPath(ellipseIn: CGRect(x: -10, y: -(frame.width / 2) - 10, width: 20, height: 20), transform: nil)
//        miniCircleContainerLayer.path = miniContainerPath
//        miniCircleContainerLayer.position = circleCenter
//        miniCircleContainerLayer.fillColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.4).cgColor
//        layer.addSublayer(miniCircleContainerLayer)
//        layer.addSublayer(circleOfProgress)
//    }
//    
//    private func updateMiniCirclePosition(for progress: CGFloat) {
//        // Обновление позиции мини-круга на основе текущего прогресса
//        let angle = (-CGFloat.pi / 2) + (2 * CGFloat.pi * progress)
//        let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
//        let xPosition = circleCenter.x + radius * cos(angle)
//        let yPosition = circleCenter.y + radius * sin(angle)
//        
//        let miniCircleCenter = CGPoint(x: xPosition - circleOfProgress.bounds.width / 2, y: yPosition - circleOfProgress.bounds.height / 2)
//        circleOfProgress.position = miniCircleCenter
//    }
    
    func setProgress(to progressConstant: CGFloat = 0.008, duration: TimeInterval = 20) {
        // Установка и анимация прогресса
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = animatedProgressLayer.strokeEnd
        animation.toValue = progressConstant
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animatedProgressLayer.strokeEnd = progressConstant
        animatedProgressLayer.add(animation, forKey: "animateProgress")
        //updateMiniCirclePosition(for: progressConstant)
    }
    
    func removeAnimation() {
        animatedProgressLayer.removeAllAnimations()
    }
}

/*рабочий код проекта чтобы комит ненужный не делать
 //
 //  MyProgressBar.swift
 //  PulseMVC
 //
 //  Created by Влад on 8.03.24.
 //
 import UIKit
 
 class MyProgressBar: UIView {
 let radius:CGFloat = 107
 let lineWidthCircle:CGFloat = 20
 
 private var staticProgressLayer: CAShapeLayer!
 private var animatedProgressLayer: CAShapeLayer!
 
 private var startPointLayer: CAShapeLayer! // Новый слой для белой точки
 
 var circlePath: UIBezierPath!
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 setupCirclePath()
 setupStaticProgressLayer()
 setupAnimatedProgressLayer()
 //setupStartPointLayer()1
 }
 
 required init?(coder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 
 private func setupCirclePath() {
 circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
 y: frame.size.height / 2.0),
 radius: radius,
 startAngle: -CGFloat.pi / 2,
 endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
 clockwise: true)
 }
 
 private func setupStaticProgressLayer() {
 staticProgressLayer = CAShapeLayer()
 staticProgressLayer.path = circlePath.cgPath
 staticProgressLayer.fillColor = UIColor.clear.cgColor
 staticProgressLayer.lineWidth = lineWidthCircle
 staticProgressLayer.strokeEnd = 0
 staticProgressLayer.strokeColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 0.4).cgColor // Цвет фиолетового прогресса
 layer.addSublayer(staticProgressLayer)
 }
 
 private func setupAnimatedProgressLayer() {
 animatedProgressLayer = CAShapeLayer()
 animatedProgressLayer.path = circlePath.cgPath
 animatedProgressLayer.fillColor = UIColor.clear.cgColor
 animatedProgressLayer.lineWidth = lineWidthCircle
 animatedProgressLayer.lineCap = .round
 animatedProgressLayer.strokeEnd = 0
 animatedProgressLayer.strokeColor = UIColor(red: 113/255, green: 102/255, blue: 249/255, alpha: 1).cgColor // Цвет фиолетового прогресса
 layer.addSublayer(animatedProgressLayer)
 }
 
 //настройка белой точки в центре
 private func setupStartPointLayer() {
 startPointLayer = CAShapeLayer()
 let center = CGPoint(x: frame.size.width / 2.0,y: frame.size.height / 2.0)
 startPointLayer.path = UIBezierPath(arcCenter: center,
 radius: 5, // Радиус белой точки
 startAngle: -CGFloat.pi / 2,
 endAngle: 2 * CGFloat.pi,
 clockwise: true).cgPath
 startPointLayer.position = center // располагаем в центре кольца
 startPointLayer.fillColor = UIColor.red.cgColor // Белый цвет точки
 layer.addSublayer(startPointLayer)
 }
 
 //настраиваем знаение прогресса на круге
 func setProgress(to progressConstant: CGFloat) {
 staticProgressLayer.strokeEnd = 1
 let animation = CABasicAnimation(keyPath: "strokeEnd")
 
 
 //animation.duration = 6
 animation.fromValue = animatedProgressLayer.strokeEnd
 animation.toValue = progressConstant
 animation.timingFunction = CAMediaTimingFunction(name: .linear)
 animatedProgressLayer.strokeEnd = progressConstant
 animatedProgressLayer.add(animation, forKey: "animateProgress")
 
 let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
 rotationAnimation.fromValue = animatedProgressLayer.strokeEnd
 rotationAnimation.toValue = progressConstant
 rotationAnimation.duration = 6
 rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
 
 //startPointLayer.speed = 1
 animatedProgressLayer.speed = 1
 
 // startPointLayer.add(rotationAnimation, forKey: nil)
 }
 }
 */
