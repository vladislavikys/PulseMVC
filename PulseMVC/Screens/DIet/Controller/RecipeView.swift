import UIKit

class RecipeView: UIViewController {
    public var backgoundImageView = UIImageView()
    
    var recipeName = NameView()
    var caloriesLabel = UILabel()
    var cookingTimeLabel = UILabel()
    var proteinIndicator = UIProgressView()
    var fatIndicator = UIProgressView()
    var carbsIndicator = UIProgressView()
    var ingredientsLabel = UITextView()
    var cookingInstructionsLabel = UITextView()
    var scrollView = UIScrollView()
    
    var recepie: Recipes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    func setupConstraints(){
        view.backgroundColor = .white
        
    }
}
