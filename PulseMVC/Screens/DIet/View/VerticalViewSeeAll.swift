import UIKit

protocol VerticalViewSeeAllDelegate: AnyObject {
    func didTapBack()
    func didSelectRecipe(at index: Int)
}

class VerticalViewSeeAll: UIView {

    weak var delegate: VerticalViewSeeAllDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"back"), for: .normal)
        button.tintColor = UIColor.black
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let itemWidth = (UIScreen.main.bounds.width - 30) / 2 // Adjust the calculation to ensure two columns
        layout.itemSize = CGSize(width: itemWidth, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backButton.isHidden = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(collectionView)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    @objc private func backButtonTapped() {
        delegate?.didTapBack()
    }
}

extension VerticalViewSeeAll: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let recipeCount = CoreDataeManager.shared.fetchAllRecipes()?.count {
            return recipeCount
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {
            fatalError("Unable to dequeue Cell")
        }
        if let recipes = CoreDataeManager.shared.fetchAllRecipes() {
            let recipe = recipes[indexPath.row]
            cell.nameLabel.text = recipe.name
            cell.caloriesLabel.text = "🔥 \(recipe.calories)kcal"
            cell.timeLabel.text = "⏰ \(recipe.cooking_time)min"
            cell.recipeImageView.image = UIImage(named: "\(String(recipe.photo!))")
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRecipe(at: indexPath.row)
    }
}
