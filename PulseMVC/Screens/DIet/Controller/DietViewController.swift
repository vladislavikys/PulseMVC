class DietViewController: BaseViewController, VerticalViewSeeAllDelegate, HorizontalViewDelegate {
    
    let breakfast = HorizontalView()
    let breakfastText = "Завтрак"
    let lunch = HorizontalView()
    let lunchText = "Обед"
    let dinner = HorizontalView()
    let dinnerText = "Ужин"
    
    var horizontalViews: [HorizontalView] = []
    var verticalView = VerticalViewSeeAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        breakfast.category = breakfastText
        breakfast.titleLabel.text = breakfastText
        breakfast.loadRecipes()
        
        lunch.category = lunchText
        lunch.titleLabel.text = lunchText
        lunch.loadRecipes()
        
        dinner.category = dinnerText
        dinner.titleLabel.text = dinnerText
        dinner.loadRecipes()
        
        horizontalViews = [breakfast, lunch, dinner]
        
        for (index, horizontalView) in horizontalViews.enumerated() {
            view.addSubview(horizontalView)
            horizontalView.tag = index + 1
            horizontalView.delegate = self // Устанавливаем делегат
        }
        
        verticalView.delegate = self
        verticalView.isHidden = true
        view.addSubview(verticalView)
    }
    
    private func setupConstraints() {
        for (index, horizontalView) in horizontalViews.enumerated() {
            horizontalView.snp.makeConstraints { make in
                if index == 0 {
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
                } else {
                    make.top.equalTo(horizontalViews[index - 1].snp.bottom)
                }
                make.left.right.equalToSuperview().inset(-10) 
                make.height.equalTo(216)
            }
        }
        
        verticalView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func didSelectRecipe(_ recipe: Recipes) {
        //  данные рецепта  в консоль
            let recipeDetails = """
            Recipe selected:
            Name: \(recipe.name ?? "No Name")
            Description: \(recipe.descript ?? "No Description")
            Ingredients: \(recipe.ingredients ?? "No Ingredients")
            Instructions: \(recipe.instructions ?? "No Instructions")
            Protein: \(recipe.protein)
            Fat: \(recipe.fat)
            Carbs: \(recipe.carbohydrates)
            """
            print(recipeDetails)
        
        let recipeView = RecipeView(recipe: recipe)
        recipeView.modalPresentationStyle = .fullScreen
        present(recipeView, animated: true)
    }
    
    func didHideAllHorizViewShowVert(from horizontalView: HorizontalView) {
        horizontalViews.forEach { $0.isHidden = true }
        verticalView.isHidden = false
        
        switch horizontalView {
        case breakfast:
            verticalView.setTitle(breakfastText)
            verticalView.category = breakfastText
        case lunch:
            verticalView.setTitle(lunchText)
            verticalView.category = lunchText
        case dinner:
            verticalView.setTitle(dinnerText)
            verticalView.category = dinnerText
        default:
            verticalView.setTitle("Рецепты")
            verticalView.category = nil
        }
        verticalView.loadRecipes()
    }
    
    func didTapBack() {
        verticalView.isHidden = true
        horizontalViews.forEach { $0.isHidden = false }
        setupConstraints()
    }
}
