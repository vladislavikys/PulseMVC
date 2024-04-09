import UIKit

class PayWallController: UIViewController {
    
    public var backgoundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let settingsNoteLabel = UILabel()
    private let continueButton: GlobalButton = {
        let button = GlobalButton()
        button.setTitle("Accept and Continue", for: .normal)
        return button
    }()
    private let cellFace = PayWallView()
    private let cellFinger = PayWallView()
    private let cellHeart = PayWallView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        setupUi()
        
    }

    func setupUi() {
        view.addSubview(titleLabel)
        view.addSubview(continueButton)
        view.addSubview(settingsNoteLabel)
        view.addSubview(cellFace)
        view.addSubview(cellFinger)
        view.addSubview(cellHeart)
        view.backgroundColor = UIColor.white

        titleLabel.text = "Allow tracking on the next creen for:"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalTo(view.snp.leadingMargin).offset(20)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-20)
        }

        
        
        
        settingsNoteLabel.text = "You can change this option later in the Settings app"
        settingsNoteLabel.textAlignment = .left
        settingsNoteLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        settingsNoteLabel.textColor = .black
        settingsNoteLabel.numberOfLines = 2
        settingsNoteLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(continueButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-190)
        }

        
        configureCell(cellFace, withEmoji: "🧑",
                      text: "Helping us find wonderful people like you through ads, to join our community and help you live a healthier life",
                      belowView: titleLabel, offset: 70)
        configureCell(cellFinger, withEmoji: "👍",
                      text: "Personalising your experience to connect you with more great content",
                      belowView: cellFace, offset: 70)
        configureCell(cellHeart, withEmoji: "❤️",
                      text: "An improved personalized experience over time",
                      belowView: cellFinger, offset: 70)
        
        
        continueButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-70)
        }
    }

    @objc func pressedButton(){
        dismiss(animated: true)
    }
}

extension PayWallController {
    //добавляем фон на экран
    func setBackground(){
        view.addSubview(backgoundImageView)
        backgoundImageView.image = UIImage(named: "backgroundColor")
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgoundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    func configureCell(_ cell: PayWallView, withEmoji emoji: String,
                       text: String, belowView view: UIView, offset: CGFloat) {
        cell.configure(with: emoji, text: text)
        cell.snp.makeConstraints { make in
            make.leading.trailing.equalTo(continueButton)
            make.top.equalTo(view.snp.bottom).offset(offset)
        }
    }
}
