import UIKit

class PayWallController: UIViewController {

    private let titleLabel = UILabel()
    //private var collectionView = UICollectionView()
    private let settingsNoteLabel = UILabel()
    private let continueButton = GlobalButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }

    func setupUi() {
        view.addSubview(titleLabel)
        view.addSubview(continueButton)
        view.addSubview(settingsNoteLabel)
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

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .clear
//        collectionView.register(PayWallCell.self, forCellWithReuseIdentifier: "PayWallCell")
//        collectionView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.width.equalTo(view.snp.width).multipliedBy(0.8) // 80% ширины экрана
//            make.height.equalTo(200)
//            make.leading.trailing.equalTo(continueButton)
//        }

        settingsNoteLabel.text = "You can change this option later in the Settings app"
        settingsNoteLabel.textAlignment = .left
        settingsNoteLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        settingsNoteLabel.textColor = .black
        settingsNoteLabel.numberOfLines = 2
        settingsNoteLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(continueButton)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-190)
        }


        continueButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-90)
        }
    }

    @objc func pressedButton(){
        dismiss(animated: true)
    }
}

//extension PayWallController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PayWallCell", for: indexPath) as! PayWallCell
//
//        switch indexPath.row {
//        case 0:
//            cell.configure(with: "😀", text: "Helping us find wonderful people like you through ads, to join our community and help you live a healthier life")
//        case 1:
//            cell.configure(with: "👍", text: "Personalising your experience to connect you with more great content")
//        case 2:
//            cell.configure(with: "❤️", text: "An improved personalized experience over time")
//        default:
//            break
//        }
//        return cell
//    }
//}
