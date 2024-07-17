import UIKit
import SnapKit

class RecipeView: UIViewController {

    // Объявляем переменные для различных UI компонентов
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

    // Объявляем переменную для хранения рецепта
    private var recipe: Recipes

    // Создаем stackView как свойство класса
    private let nutrientStackView = UIStackView()

    // Создаем главный stackView для содержимого scrollView
    private let contentStackView = UIStackView()
    private let ingredientsStackView = UIStackView()
    private let instructionsStackView = UIStackView()

    init(recipe: Recipes) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateUI()
        setupIngredientList() // Вызываем метод для настройки отображения списка ингредиентов
        setupInstructions() // Вызываем метод для настройки отображения инструкций
    }

    private func setupViews() {
        view.backgroundColor = .white

        // Настройка кнопки назад
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = UIColor.black
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Добавляем все UI компоненты на главный вид
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(recipeImageView)
        contentStackView.addArrangedSubview(recipeNameView)
        contentStackView.addArrangedSubview(nutrientStackView)
        contentStackView.addArrangedSubview(ingredientsStackView)
        contentStackView.addArrangedSubview(instructionsStackView)
        view.addSubview(backButton)

        recipeImageView.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray

        setupNutrientIndicators()

        // Настраиваем contentStackView
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.alignment = .fill

        // Настраиваем ingredientsStackView
        ingredientsStackView.axis = .vertical
        ingredientsStackView.spacing = 5
        ingredientsStackView.alignment = .fill
        
        // Настраиваем instructionsStackView
        instructionsStackView.axis = .vertical
        instructionsStackView.spacing = 10
        instructionsStackView.alignment = .fill
    }

    private func setupNutrientIndicators() {
        // Настройка stackView
        nutrientStackView.axis = .horizontal
        nutrientStackView.spacing = 20
        nutrientStackView.alignment = .center
        nutrientStackView.distribution = .equalSpacing

        let indicators: [(CircularProgressView, UILabel, String)] = [
            (proteinIndicator, proteinIndicatorText, "Protein"),
            (fatIndicator, fatIndicatorText, "Fat"),
            (carbsIndicator, carbsIndicatorText, "Carbs")
        ]

        for (indicator, textLabel, title) in indicators {
            textLabel.text = title
            textLabel.textAlignment = .center
            textLabel.numberOfLines = 0

            let stackViewItem = UIStackView()
            stackViewItem.axis = .vertical
            stackViewItem.spacing = 25
            stackViewItem.alignment = .center
            stackViewItem.addArrangedSubview(textLabel)
            stackViewItem.addArrangedSubview(indicator)

            nutrientStackView.addArrangedSubview(stackViewItem)
        }
    }

    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        recipeImageView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }

        recipeNameView.snp.makeConstraints { make in
            make.height.equalTo(140)
        }

        nutrientStackView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }

    private func updateUI() {
        // Обновляем интерфейс данными рецепта
        recipeNameView.name = recipe.name ?? "No Name"
        recipeNameView.opinion = recipe.descript ?? "No Opinion"
        recipeNameView.kcal = Int(recipe.calories)
        recipeNameView.min = Int(recipe.cooking_time)
        recipeNameView.serv = Int(recipe.servings)

        recipeImageView.image = UIImage(named: "\(String(recipe.photo ?? ""))")

        // Устанавливаем значения для круговых индикаторов
        proteinIndicator.progress = Float(recipe.protein) / 100.0
        fatIndicator.progress = Float(recipe.fat) / 100.0
        carbsIndicator.progress = Float(recipe.carbohydrates) / 100.0

        // Устанавливаем текст для индикаторов
        proteinIndicatorText.text = "Protein: \(recipe.protein)"
        fatIndicatorText.text = "Fat: \(recipe.fat)"
        carbsIndicatorText.text = "Carbs: \(recipe.carbohydrates)"
    }

    private func setupIngredientList() {
        let ingredientsTitle = UILabel()
        ingredientsTitle.text = "Ingredient list"
        ingredientsTitle.font = UIFont.boldSystemFont(ofSize: 18)
        ingredientsStackView.addArrangedSubview(ingredientsTitle)

        guard let ingredientsText = recipe.ingredients else { return }
        let ingredients = ingredientsText.split(separator: "\n")
        for ingredient in ingredients {
            let label = UILabel()
            label.text = String(ingredient)
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .red
            ingredientsStackView.addArrangedSubview(label)
        }
    }

    private func setupInstructions() {
        let instructionsTitle = UILabel()
        instructionsTitle.text = "Cooking Instructions"
        instructionsTitle.font = UIFont.boldSystemFont(ofSize: 18)
        instructionsStackView.addArrangedSubview(instructionsTitle)

        guard let instructionsText = recipe.instructions else { return }
        let instructionsLabel = UILabel()
        instructionsLabel.text = instructionsText
        instructionsLabel.font = UIFont.systemFont(ofSize: 16)
        instructionsLabel.textColor = .black
        instructionsLabel.numberOfLines = 0
        instructionsStackView.addArrangedSubview(instructionsLabel)
    }

    // Обработчик нажатия кнопки назад
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
