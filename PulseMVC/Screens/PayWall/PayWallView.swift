import UIKit

class PayWallView: UIView {
    private let emojiContainer = UIView()
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
        addSubview(emojiContainer)
        addSubview(textLabel)
        
        emojiContainer.backgroundColor = .white
        emojiContainer.layer.borderColor = UIColor.lightGray.cgColor
        emojiContainer.layer.borderWidth = 1
        
        emojiContainer.layer.cornerRadius = 18
        emojiLabel.textAlignment = .center
        emojiContainer.addSubview(emojiLabel)
        
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.numberOfLines = 3
        textLabel.lineBreakMode = .byWordWrapping
        
        emojiContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(45)
        }
        
        emojiLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(emojiContainer.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(emojiContainer.snp.centerY)
        }
    }

    func configure(with emoji: String, text: String) {
        emojiLabel.text = emoji
        textLabel.text = text
    }
}
