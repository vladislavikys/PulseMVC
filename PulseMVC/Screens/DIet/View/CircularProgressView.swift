import UIKit

class CircularProgressView: UIView {

    private let shapeLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private let percentageLabel = UILabel()
    
    var progress: Float = 0 {
        didSet {
            updateProgress()
            updatePercentageLabel()
        }
    }
    
    var lineWidth: CGFloat = 5 { // Уменьшение толщины линии
        didSet {
            shapeLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth
            setNeedsLayout()
        }
    }

    var progressColor: UIColor = .orange {
        didSet {
            shapeLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var backgroundLayerColor: UIColor = .lightGray { // Светло-серый цвет для фона
        didSet {
            backgroundLayer.strokeColor = backgroundLayerColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = backgroundLayerColor.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = .round
        layer.addSublayer(backgroundLayer)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = progressColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
        
        percentageLabel.font = UIFont.systemFont(ofSize: 16)
        percentageLabel.textAlignment = .center
        percentageLabel.textColor = .black
        addSubview(percentageLabel)
    }
    
    private func updateProgress() {
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let startAngle: CGFloat = -(.pi / 2)
        let endAngle: CGFloat = .pi * 2 * CGFloat(progress) - (.pi / 2)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        shapeLayer.path = path.cgPath
        
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        backgroundLayer.path = backgroundPath.cgPath
    }
    
    private func updatePercentageLabel() {
        percentageLabel.text = "\(Int(progress * 100))%"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateProgress()
        percentageLabel.frame = bounds
    }
}
