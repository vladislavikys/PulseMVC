import UIKit

class DietViewController: BaseViewController, VerticalViewSeeAllDelegate {
    
    // Горизонтальные представления для завтрака, обеда и ужина
    let breakfast = HorizontalView()
    let breakfastText = "Завтрак"
    let lunch = HorizontalView()
    let lunchText = "Обед"
    let dinner = HorizontalView()
    let dinnerText = "Ужин"
    
    var horizontalViews: [HorizontalView] = [] // Массив для хранения горизонтальных представлений
    var verticalView = VerticalViewSeeAll() // Вертикальное представление для отображения всех рецептов
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews() // Настройка визуальных компонентов
        setupConstraints() // Установка ограничений
    }
    
    private func setupViews() {
        // Настройка завтрака
        breakfast.category = breakfastText
        breakfast.titleLabel.text = breakfastText
        breakfast.loadRecipes()
        
        // Настройка обеда
        lunch.category = lunchText
        lunch.titleLabel.text = lunchText
        lunch.loadRecipes()
        
        // Настройка ужина
        dinner.category = dinnerText
        dinner.titleLabel.text = dinnerText
        dinner.loadRecipes()
        
        // Добавляем горизонтальные представления в массив и на экран
        horizontalViews = [breakfast, lunch, dinner]
        
        for (index, horizontalView) in horizontalViews.enumerated() {
            view.addSubview(horizontalView)
            horizontalView.tag = index + 1 // Присваиваем тег для идентификации
            horizontalView.delegate = self // Устанавливаем делегат
        }
        
        // Настройка вертикального представления
        verticalView.delegate = self
        verticalView.isHidden = true // Скрываем изначально
        view.addSubview(verticalView)
    }
    
    private func setupConstraints() {
        // Установка ограничений для горизонтальных представлений
        for (index, horizontalView) in horizontalViews.enumerated() {
            horizontalView.snp.makeConstraints { make in
                if index == 0 {
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14) // Отступ от верхней границы для первого представления
                } else {
                    make.top.equalTo(horizontalViews[index - 1].snp.bottom) // Размещаем представления друг под другом
                }
                make.left.right.equalToSuperview().inset(-15) // Выравниваем по краям экрана с отступом
                make.height.equalTo(216) // Фиксированная высота представления
            }
        }
        
        verticalView.snp.makeConstraints { make in
            make.edges.equalToSuperview() 
        }
    }
}

// Расширение для обработки событий горизонтальных представлений
extension DietViewController: HorizontalViewDelegate {
    // Обработка выбора рецепта из горизонтального представления
    func didSelectRecipe(at index: Int) {
        let recipeView = RecipeView() // Создаем экран для просмотра рецепта
        present(recipeView, animated: true) // Открываем экран с анимацией
    }
    
    // Обработка события нажатия на "See All" в горизонтальном представлении
    func didHideAllHorizViewShowVert(from horizontalView: HorizontalView) {
        horizontalViews.forEach { $0.isHidden = true } // Скрываем все горизонтальные представления
        verticalView.isHidden = false // Показываем вертикальное представление
        
        // Устанавливаем заголовок и категорию для вертикального представления в зависимости от выбранного горизонтального представления
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
    
    // Обработка события нажатия кнопки "Назад" в вертикальном представлении
    func didTapBack() {
        verticalView.isHidden = true // Скрываем вертикальное представление
        horizontalViews.forEach { $0.isHidden = false } // Показываем все горизонтальные представления
        setupConstraints() // Переустанавливаем ограничения для горизонтальных представлений
    }
}
