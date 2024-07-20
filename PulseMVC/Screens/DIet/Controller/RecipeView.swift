import UIKit
import SnapKit

class RecipeView: UIViewController {

    // Объявляем переменные для различных UI компонентов 🎨
    var recipeNameView = NameView()
    var recipeImageView = UIImageView()
    var proteinIndicator = CircularProgressView()
    let proteinIndicatorText = UILabel()
    var fatIndicator = CircularProgressView()
    let fatIndicatorText = UILabel()
    var carbsIndicator = CircularProgressView()
    let carbsIndicatorText = UILabel()
    var scrollView = UIScrollView()
    private let backButton = UIButton(type: .system)

    // Объявляем переменную для хранения рецепта 🍲
    private var recipe: Recipes

    // Создаем stackView как свойство класса 📚
    private let nutrientStackView = UIStackView()

    // Создаем главный stackView для содержимого scrollView 📜
    private let contentStackView = UIStackView()
    private let ingredientsStackView = UIStackView()
    private let instructionsStackView = UIStackView()

    // Инициализируем с рецептом 🥗
    init(recipe: Recipes) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Когда вид загружается 🔄
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()        // Настраиваем вид
        setupConstraints()  // Устанавливаем ограничения
        updateUI()          // Обновляем UI данными рецепта
        setupIngredientList() // Настраиваем список ингредиентов
        setupInstructions() // Настраиваем инструкции по готовке
        printIngredients()  // Печатаем ингредиенты в консоль 🖨️
    }

    private func setupViews() {
        view.backgroundColor = .white // Белый фон 🎨

        // Настройка кнопки назад 🔙
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = UIColor.black
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Добавляем все UI компоненты на главный вид 🏗️
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        scrollView.addSubview(recipeNameView) // Добавляем recipeNameView в scrollView, а не в contentStackView
        contentStackView.addArrangedSubview(recipeImageView)
        contentStackView.addArrangedSubview(nutrientStackView)
        contentStackView.addArrangedSubview(ingredientsStackView)
        contentStackView.addArrangedSubview(instructionsStackView)
        view.addSubview(backButton)

        recipeImageView.contentMode = .scaleAspectFill
        

        setupNutrientIndicators() // Настраиваем индикаторы питательных веществ 📊

        // Настраиваем contentStackView 📚
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.alignment = .fill

        // Настраиваем ingredientsStackView 🥕
        ingredientsStackView.axis = .vertical
        ingredientsStackView.spacing = 5
        ingredientsStackView.alignment = .fill
        
        // Настраиваем instructionsStackView 📜
        instructionsStackView.axis = .vertical
        instructionsStackView.spacing = 10
        instructionsStackView.alignment = .fill
    }

    private func setupNutrientIndicators() {
        // Настройка stackView для индикаторов питательных веществ 🍽️
        nutrientStackView.axis = .horizontal
        nutrientStackView.spacing = 5
        nutrientStackView.alignment = .center
        nutrientStackView.distribution = .equalSpacing

        let indicators: [(CircularProgressView, String)] = [
            (proteinIndicator, "Protein"),
            (fatIndicator, "Fat"),
            (carbsIndicator, "Carbs")
        ]

        // Устанавливаем начальную ширину линии для индикаторов
        indicators.forEach { $0.0.lineWidth = 5 }

        // Добавляем каждый индикатор и его метку в стек 🏗️
        for (indicator, title) in indicators {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 1
            titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)

            let valueLabel = UILabel()
            valueLabel.textAlignment = .center
            valueLabel.numberOfLines = 1
            valueLabel.textColor = .gray
            valueLabel.font = UIFont.systemFont(ofSize: 14)

            let stackViewItem = UIStackView()
            stackViewItem.axis = .vertical
            stackViewItem.spacing = 8
            stackViewItem.alignment = .center
            stackViewItem.addArrangedSubview(indicator)
            stackViewItem.addArrangedSubview(titleLabel)
            stackViewItem.addArrangedSubview(valueLabel)

            indicator.snp.makeConstraints { make in
                make.width.height.equalTo(60) // Устанавливаем размер индикаторов
            }

            nutrientStackView.addArrangedSubview(stackViewItem)

            // Обновляем текст значения в зависимости от типа индикатора
            if indicator == proteinIndicator {
                valueLabel.text = "\(recipe.protein)g"
            } else if indicator == fatIndicator {
                valueLabel.text = "\(recipe.fat)g"
            } else if indicator == carbsIndicator {
                valueLabel.text = "\(recipe.carbohydrates)g"
            }
        }
    }

    private func setupConstraints() {
        // Устанавливаем ограничения для кнопки назад 🛠️
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }

        // Устанавливаем ограничения для scrollView 📜
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        // Устанавливаем ограничения для contentStackView 📚
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        // Устанавливаем высоту для изображения рецепта 📸
        recipeImageView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }

        // Устанавливаем высоту и ширину для названия рецепта 📜
        recipeNameView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(-45)
            make.height.equalTo(130)
            make.width.equalTo(320)
            make.centerX.equalTo(scrollView)
        }

        // Устанавливаем высоту для nutrientStackView 🍽️
        nutrientStackView.snp.makeConstraints { make in
            make.top.equalTo(recipeNameView.snp.bottom).offset(40)
            make.height.equalTo(120)
        }

        // Устанавливаем отступ для ingredientsStackView 🥕
        ingredientsStackView.snp.makeConstraints { make in
            make.top.equalTo(nutrientStackView.snp.bottom).offset(40)
        }

        // Устанавливаем отступ для instructionsStackView 📜
        instructionsStackView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsStackView.snp.bottom).offset(40)
        }
    }


    private func updateUI() {
        // Обновляем интерфейс данными рецепта 📋
        recipeNameView.name = recipe.name ?? "No Name"
        recipeNameView.opinion = recipe.descript ?? "No Opinion"
        recipeNameView.kcal = Int(recipe.calories)
        recipeNameView.min = Int(recipe.cooking_time)
        recipeNameView.serv = Int(recipe.servings)

        recipeImageView.image = UIImage(named: "\(String(recipe.photo ?? ""))")

        // Устанавливаем значения для круговых индикаторов 🎯
        let totalNutrients = Float(recipe.protein + recipe.fat + recipe.carbohydrates)
        
        if totalNutrients > 0 {
            proteinIndicator.progress = Float(recipe.protein) / totalNutrients
            fatIndicator.progress = Float(recipe.fat) / totalNutrients
            carbsIndicator.progress = Float(recipe.carbohydrates) / totalNutrients
        } else {
            proteinIndicator.progress = 0
            fatIndicator.progress = 0
            carbsIndicator.progress = 0
        }
    }

    private func setupIngredientList() {
        // Заголовок для списка ингредиентов 🥕
        let ingredientsTitle = UILabel()
        ingredientsTitle.text = "Ingredient list"
        ingredientsTitle.font = UIFont.boldSystemFont(ofSize: 18)
        ingredientsStackView.addArrangedSubview(ingredientsTitle)

        // Добавляем ингредиенты в стек 📜
        guard let ingredientDetails = recipe.ingredientDetails else { return }
        for (ingredient, quantity) in ingredientDetails {
            let label = UILabel()
            label.text = formatIngredientText(ingredient: ingredient, quantity: quantity)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .black
            label.textAlignment = .left
            ingredientsStackView.addArrangedSubview(label)
        }

        // Добавляем отступы слева и справа по 25 пунктов
        ingredientsStackView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        ingredientsStackView.isLayoutMarginsRelativeArrangement = true
    }

    private func setupInstructions() {
        // Заголовок для инструкций по готовке 📜
        let instructionsTitle = UILabel()
        instructionsTitle.text = "Cooking Instructions"
        instructionsTitle.font = UIFont.boldSystemFont(ofSize: 18)
        instructionsStackView.addArrangedSubview(instructionsTitle)

        // Добавляем инструкции в стек 📜
        guard let instructionsText = recipe.instructions else { return }
        let instructionsLabel = UILabel()
        instructionsLabel.text = instructionsText
        instructionsLabel.font = UIFont.systemFont(ofSize: 16)
        instructionsLabel.textColor = .black
        instructionsLabel.numberOfLines = 0
        instructionsStackView.addArrangedSubview(instructionsLabel)

        // Добавляем отступы слева и справа по 25 пунктов
        instructionsStackView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        instructionsStackView.isLayoutMarginsRelativeArrangement = true
    }

    // Обработчик нажатия кнопки назад 🔙
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    // Метод для печати ингредиентов в консоль 🖨️
    private func printIngredients() {
        print("Ingredients for recipe: \(recipe.name ?? "No Name")")
        guard let ingredientDetails = recipe.ingredientDetails else {
            print("No ingredients found.")
            return
        }
        for (ingredient, quantity) in ingredientDetails {
            print("\(ingredient): \(quantity)")
        }
    }

    // Метод для форматирования текста ингредиентов с точками 🟢
    private func formatIngredientText(ingredient: String, quantity: String) -> String {
        let totalWidth = Int(view.bounds.width) - 40 // Оставляем место для отступов
        let font = UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        let ingredientSize = (ingredient as NSString).size(withAttributes: attributes)
        let quantitySize = (quantity as NSString).size(withAttributes: attributes)
        
        let dotsCount = (totalWidth - Int(ingredientSize.width) - Int(quantitySize.width)) / 5
        let dots = String(repeating: ".", count: max(dotsCount, 0))
        
        return "\(ingredient) \(dots) \(quantity)"
    }
}
