import UIKit

class ProgressBar: UIView {
    
    // Слой для отображения прогресса
    var trackLayer = CAShapeLayer()
    var shapeLayer = CAShapeLayer()
    
    // Слой для мини-круглого прогресса
    var miniProgressLayer = CAShapeLayer()
    var miniCircleContainerLayer = CAShapeLayer()
    
    // Параметры прогресса
    public var radius: CGFloat = 107.0
    public var lineWidth: CGFloat = 20.0
    
    // Инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupHeartRateMeasurement(type: true)
    }
    
    // Расположение элементов при изменении размеров вида
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // Инициализатор не реализован, так как не предполагается использование загрузки из xib/storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка прогресса для измерения пульса
    func setupHeartRateMeasurement(type: Bool) {
        // Удаление предыдущих слоев, если они есть
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        // Создание круговой траектории
        let circlePath = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: -.pi / 2, endAngle: .pi * 2, clockwise: true)
        
        // Настройка основного слоя для отображения прогресса
        // Устанавливаем начальное значение прогресса в 0
        shapeLayer.strokeEnd = 0

        // Устанавливаем траекторию (путь) для отображения прогресса в виде круга
        shapeLayer.path = circlePath.cgPath

        // Заполняем цвет заливки слоя прогресса
        shapeLayer.fillColor = UIColor.clear.cgColor

        // Устанавливаем стиль конца линии (круглый)
        shapeLayer.lineCap = .round

        // Устанавливаем толщину линии прогресса
        shapeLayer.lineWidth = lineWidth

        // Устанавливаем цвет линии прогресса
        shapeLayer.strokeColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 1).cgColor

        
        // Настройка слоя для отображения трека (фона) прогресса
        trackLayer.path = circlePath.cgPath // Устанавливаем траекторию (путь) для отображения трека в виде круга
        trackLayer.fillColor = UIColor.clear.cgColor // Заполняем цвет заливки трека как прозрачный
        trackLayer.lineCap = .round // Устанавливаем стиль конца линии трека в круглый
        trackLayer.lineWidth = lineWidth // Устанавливаем толщину линии трека согласно заданному lineWidth
        trackLayer.strokeColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 0.4).cgColor // Устанавливаем цвет линии трека с помощью RGB и альфа-канала

        
        // Добавление слоев на вида
        layer.addSublayer(trackLayer)
        layer.addSublayer(shapeLayer)
        
        // Если указан тип true, то добавляем мини-круглый прогресс
        if type {
            let circleCenter = CGPoint(x: bounds.midX, y: bounds.midY)
            
            // Настройка мини-круглого прогресса
            let miniPath = CGPath(ellipseIn: CGRect(x: -5, y: -(frame.width / 2) - 1.8, width: 10, height: 10), transform: nil)
            miniProgressLayer.path = miniPath
            miniProgressLayer.position = circleCenter
            miniProgressLayer.fillColor = UIColor.white.cgColor
            
            // Настройка контейнера для мини-круглого прогресса
            let miniContainerPath = CGPath(ellipseIn: CGRect(x: -10, y: -(frame.width / 2) - 6.9, width: 20, height: 20), transform: nil)
            miniCircleContainerLayer.path = miniContainerPath
            miniCircleContainerLayer.position = circleCenter
            miniCircleContainerLayer.fillColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 1).cgColor
            
            // Добавление слоев мини-круглого прогресса на вида
            layer.addSublayer(miniCircleContainerLayer)
            layer.addSublayer(miniProgressLayer)
        }
    }
    
    // Анимация прогресса
    func animation(duration: TimeInterval) {
        // Анимация основного прогресса
        // Создание анимации для отображения прогресса сердечного ритма
        let heartRateAnimation = CABasicAnimation(keyPath: "strokeEnd")
        heartRateAnimation.fromValue = 0               // Начальное значение анимации (отсутствие прогресса)
        heartRateAnimation.toValue = 1                 // Конечное значение анимации (полный прогресс)
        heartRateAnimation.duration = 25                // Длительность анимации в секундах
        heartRateAnimation.timingFunction = CAMediaTimingFunction(name: .linear)  // Линейная функция времени
        heartRateAnimation.isRemovedOnCompletion = false  // Оставить анимацию после завершения
        heartRateAnimation.fillMode = .forwards         // Заполнить состоянием анимации после завершения

        
        // Создание анимации вращения для мини-круглого прогресса
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0                          // Начальный угол вращения (в радианах)
        rotationAnimation.toValue = 2 * CGFloat.pi               // Конечный угол вращения (полный оборот в радианах)
        rotationAnimation.duration = duration                      // Длительность анимации в секундах
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)  // Линейная функция времени
        rotationAnimation.isRemovedOnCompletion = false           // Оставить анимацию после завершения
        rotationAnimation.fillMode = .forwards                    // Заполнить состоянием анимации после завершения

        
        // Запуск анимации
        miniProgressLayer.speed = 1.0
        shapeLayer.speed = 1.0
        
        // Добавление анимации вращения для мини-круглого прогресса
        miniProgressLayer.add(rotationAnimation, forKey: nil)

        // Добавление анимации для отображения прогресса сердечного ритма
        shapeLayer.add(heartRateAnimation, forKey: "progressAnim")

    }
    
    // Остановка анимации
    func stopAnimation() {
        miniProgressLayer.speed = 0.0
        shapeLayer.speed = 0.0
    }
}

