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

    // Добавляем кнопку назад
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.tintColor = UIColor.black
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    // Объявляем переменную для хранения рецепта
    private var recipe: Recipes

    // Создаем stackView как свойство класса
    private let nutrientStackView = UIStackView()

    // Создаем stackView для списка ингредиентов
    private let ingredientsStackView = UIStackView()

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
        displayRecipe()
        setupIngredientList() // Вызываем метод для настройки отображения списка ингредиентов
    }

    private func setupViews() {
        view.backgroundColor = .white

        // Добавляем все UI компоненты на главный вид
        view.addSubview(recipeImageView)
        view.addSubview(recipeNameView)
        view.addSubview(scrollView)
        view.addSubview(nutrientStackView)
        view.addSubview(backButton) // Добавляем кнопку назад

        recipeImageView.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray

        setupNutrientIndicators()

        scrollView.addSubview(ingredientsStackView)

        // Настраиваем ingredientsStackView
        ingredientsStackView.axis = .vertical  // Устанавливаем вертикальную ось
        ingredientsStackView.spacing = 5
        ingredientsStackView.alignment = .fill
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

        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(-1)
            make.right.equalToSuperview().offset(-1)
            make.height.equalTo(250)
        }

        recipeNameView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(-40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(140)
        }

        nutrientStackView.snp.makeConstraints { make in
            make.top.equalTo(recipeNameView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(120)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(nutrientStackView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        ingredientsStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
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

    private func displayRecipe() {
        print("Recipe Details:")
        print("Name: \(recipe.name ?? "No Name")")
        print("Description: \(recipe.descript ?? "No Description")")
        print("Ingredients: \(recipe.ingredients ?? "No Ingredients")")
        print("Instructions: \(recipe.instructions ?? "No Instructions")")
        print("Protein: \(recipe.protein)")
        print("Fat: \(recipe.fat)")
        print("Carbs: \(recipe.carbohydrates)")
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

    // Обработчик нажатия кнопки назад
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
