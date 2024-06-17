import UIKit

protocol HorizontalViewDelegate: AnyObject {
    func didSelectRecipe(at index: Int)
}

class HorizontalView: UIView {
    weak var delegate: HorizontalViewDelegate?
    
    weak var parentViewController: UIViewController?
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let allLabel: UILabel = {
        let label = UILabel()
        label.text = "See All"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(allLabel)
        addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(36)
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
        allLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-36)
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(160)
        }
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSeeAllTap))
        allLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleSeeAllTap() {
        print("See All tapped")
    }
}

extension HorizontalView: UICollectionViewDataSource, UICollectionViewDelegate {
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
