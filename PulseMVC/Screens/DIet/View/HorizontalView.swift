import UIKit
import CoreData

// Протокол делегата для обратного вызова событий
protocol HorizontalViewDelegate: AnyObject {
    func didSelectRecipe(at index: Int) // Метод вызывается при выборе рецепта
    func didHideAllHorizViewShowVert(from horizontalView: HorizontalView) // Метод вызывается при нажатии "See All"
}

class HorizontalView: UIView {

    weak var delegate: HorizontalViewDelegate?
    var category: String? // Свойство для хранения категории
    private var recipes: [Recipes] = [] // Массив для хранения рецептов
    
    // Метка заголовка
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    // Метка "See All"
    let allLabel: UILabel = {
        let label = UILabel()
        label.text = "See All"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.isUserInteractionEnabled = true // Включаем пользовательские взаимодействия
        return label
    }()
    
    // Коллекция для отображения рецептов
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // Направление прокрутки - горизонтальное
        layout.itemSize = CGSize(width: 140, height: 160) // Размер ячейки
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell") // Регистрация ячейки
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews() // Инициализация визуальных компонентов
        setupTapGesture() // Инициализация жеста нажатия на "See All"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Установка визуальных компонентов
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(allLabel)
        addSubview(collectionView)
        
        // Ограничения для заголовка
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(36)
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
        
        // Ограничения для метки "See All"
        allLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-36)
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
        
        // Ограничения для коллекции рецептов
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(160)
        }
    }
    
    // Установка жеста нажатия на метку "See All"
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSeeAllTap))
        allLabel.addGestureRecognizer(tapGesture) // Добавляем жест нажатия на метку "See All"
    }
    
    // Обработчик нажатия на метку "See All"
    @objc private func handleSeeAllTap() {
        print("See All tapped")
        delegate?.didHideAllHorizViewShowVert(from: self) // Вызываем метод делегата при нажатии на "See All"
    }
    
    // Функция для загрузки и отображения рецептов по категории
    func loadRecipes() {
        guard let category = category else {
            // Если категория не задана, не загружаем рецепты
            return
        }
        
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            recipes = try CoreDataeManager.shared.context.fetch(fetchRequest) // Получаем рецепты из базы данных
            collectionView.reloadData() // Обновляем коллекцию
        } catch {
            print("Failed to fetch recipes for category \(category): \(error)")
        }
    }
}

// Расширение для работы с коллекцией
extension HorizontalView: UICollectionViewDataSource, UICollectionViewDelegate {
    // Количество элементов в коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    // Создание и настройка ячейки коллекции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? Cell else {
            fatalError("Unable to dequeue Cell")
        }
        
        let recipe = recipes[indexPath.row]
        cell.nameLabel.text = recipe.name // Название рецепта
        cell.caloriesLabel.text = "🔥 \(recipe.calories)kcal" // Калории
        cell.timeLabel.text = "⏰ \(recipe.cooking_time)min" // Время приготовления
        cell.recipeImageView.image = UIImage(named: "\(String(recipe.photo!))") // Изображение рецепта
        
        return cell
    }
    
    // Обработка выбора ячейки коллекции
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRecipe(at: indexPath.row) // Вызываем метод делегата при выборе рецепта
    }
}
