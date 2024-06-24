import UIKit
import SnapKit

class RecipeView: UIViewController {

    var recipeName = NameView()

    var recipeImageView = UIImageView()

    var descriptionLabel = UILabel()

    var proteinIndicator = UIProgressView()
    let proteinIndicatorText = UILabel()
    var fatIndicator = UIProgressView()
    let fatIndicatorText = UILabel()
    var carbsIndicator = UIProgressView()
    let carbsIndicatorText = UILabel()

    var ingredientsListLabel = UITextView()
    var cookingInstructionsLabel = UITextView()

    var scrollView = UIScrollView()

    var recipe: Recipes?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.backgroundColor = .white

        // Recipe image setup
        recipeImageView.contentMode = .scaleAspectFill
        view.addSubview(recipeImageView)

        // Recipe name setup
        recipeName.backgroundColor = .red
        view.addSubview(recipeName)

        // Description label setup
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)

        // Nutrient indicators setup
        proteinIndicatorText.text = "Protein"
        view.addSubview(proteinIndicatorText)

        fatIndicatorText.text = "Fat"
        view.addSubview(fatIndicatorText)

        carbsIndicatorText.text = "Carbs"
        view.addSubview(carbsIndicatorText)

        // Ingredients list setup
        ingredientsListLabel.isEditable = false
        view.addSubview(ingredientsListLabel)

        // Cooking instructions setup
        cookingInstructionsLabel.isEditable = false
        view.addSubview(cookingInstructionsLabel)

        // Scroll view setup
        scrollView.addSubview(ingredientsListLabel)
        scrollView.addSubview(cookingInstructionsLabel)
        view.addSubview(scrollView)
    }

    func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(250)
        }

        recipeName.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).inset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(140)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeName.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        
        proteinIndicatorText.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }

        fatIndicatorText.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }

        carbsIndicatorText.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }


        scrollView.snp.makeConstraints { make in
            make.top.equalTo(carbsIndicator.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        ingredientsListLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.height.equalTo(200) // Adjust based on content
        }

        cookingInstructionsLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsListLabel.snp.bottom).offset(10)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.height.equalTo(300) // Adjust based on content
        }
    }
}
