import UIKit
import CoreData

// Протокол делегата для обратного вызова событий
protocol VerticalViewSeeAllDelegate: AnyObject {
    func didTapBack() // Метод вызывается при нажатии кнопки назад
    func didSelectRecipe(at index: Int) // Метод вызывается при выборе рецепта
}

class VerticalViewSeeAll: UIView {

    weak var delegate: VerticalViewSeeAllDelegate?
    var category: String? // Свойство для хранения категории
    private var recipes: [Recipes] = [] // Массив для хранения рецептов
    
    // Метка заголовка
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Title"
        label.textAlignment = .center
        return label
    }()
    
    // Кнопка назад
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named:"back"), for: .normal)
        button.tintColor = UIColor.black
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Коллекция для отображения рецептов
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let itemWidth = (UIScreen.main.bounds.width - 30 - 20) / 2 // Вычисляем ширину для двух столбцов
        layout.itemSize = CGSize(width: itemWidth, height: 160) // Задаем размеры ячейки
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell") // Регистрируем ячейку
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews() // Инициализация визуальных компонентов
        setupSwipeGesture() // Инициализация свайп-жеста для возврата назад
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Установка визуальных компонентов
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(collectionView)
        
        // Ограничения для кнопки назад
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
        
        // Ограничения для заголовка
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
        }
        
        // Ограничения для коллекции рецептов
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }

    // Установка заголовка
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    // Обработчик нажатия кнопки назад
    @objc private func backButtonTapped() {
        delegate?.didTapBack() // Вызываем метод делегата при нажатии кнопки назад
    }
    
    // Загрузка и отображение рецептов по категории
    func loadRecipes() {
        guard let category = category else {
            // Если категория не задана, выходим из функции
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
    
    // Инициализация свайп-жеста для возврата назад
    private func setupSwipeGesture() {
        let swipeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.edges = .left // Настройка свайпа с левой стороны экрана
        self.addGestureRecognizer(swipeGesture) // Добавление свайп-жеста к представлению
    }
    
    // Обработчик свайп-жеста для возврата назад
    @objc private func handleSwipeGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .ended {
            delegate?.didTapBack() // Вызываем метод делегата при завершении свайпа
        }
    }
}

extension VerticalViewSeeAll: UICollectionViewDataSource, UICollectionViewDelegate {
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
