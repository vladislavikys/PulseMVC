import UIKit
import CoreData
import AVKit

//ЖОПА
class PulseViewController: BaseViewController {
    private var buttonInfo = UIButton()
    private var pulseStatusLabel = UILabel()
    private var underRingLabel = UILabel()
    private var fingerOnCameraGuide = UIImageView()
    private var cameraFingerGuideText = UILabel()
    private var heartbeatGraphView = UIImageView()
    
    private var startButton = GlobalButton()
    private var progressBar = MyProgressBar()
    private var pulseStackView: PulseStack!
    
    private var welcomeView = WelcomeView()
    private var cameraView = CameraAccessView()
    var dimmy = DimmyView()
    var userProfile = AboutModel()
    
    
    var heartRateManager: HeartRateManager! // Менеджер для измерения сердечного ритма
    var bpmForCalculating: [Int] = [] // Массив для хранения значений BPM
    var validFrameCounter = 0 // Счетчик валидных кадров
    var timer = Timer() // Таймер
    var timerTwo = Timer() // Второй таймер

    
    //таймер для прогресса
    private var progressTimer: Timer?
    private var currentProgress: CGFloat = 0.0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fingerOnCameraGuide.isHidden = true
        hideWelcomeView()
        hideCameraView()
        if UserDefaults.standard.bool(forKey: "userEnteringWelcom") {
            print("пользователь уже вхоли -viewDidLoad ")
            hideWelcomeView()
        } else {
            print("первый раз вощелЭ - viewDidLoad")
            showWelcomeView()
            UserDefaults.standard.set(true, forKey: "userEnteringWelcom")
        }
    }
    
    func setupUI() {
        //buttonInfo
        buttonInfo.setImage(UIImage(named: "buttonInfo"), for: .normal)
        view.addSubview(buttonInfo)
        buttonInfo.snp.makeConstraints { make in
            make.top.equalTo(view).offset(78)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-5)
            make.width.height.equalTo(24)
        }
        
        //Title name screen
        titleLabel.text = "Heart rate"
        
        //pulseStatusLabel
        pulseStatusLabel.text = "No finger"
        pulseStatusLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.addSubview(pulseStatusLabel)
        pulseStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(125)
            make.centerX.equalTo(view)
        }
        
        //cameraFingerGuideText
        cameraFingerGuideText.isHidden = true
        cameraFingerGuideText.text = "Place your finger on the back camera and flashlight"
        cameraFingerGuideText.textAlignment = .center
        cameraFingerGuideText.numberOfLines = 2
        view.addSubview(cameraFingerGuideText)
        cameraFingerGuideText.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(460)
            make.leading.equalTo(view).offset(55)
            make.trailing.equalTo(view).offset(-55)
        }
        
        //fingerOnCameraGuide
        fingerOnCameraGuide.image = UIImage(named: "fingerOnCameraGuide")
        view.addSubview(fingerOnCameraGuide)
        fingerOnCameraGuide.snp.makeConstraints { make in
            make.top.equalTo(560)
            make.centerX.equalTo(view)
        }
        
        //heartbeatGraphView
        heartbeatGraphView.image = UIImage(named: "heartbeat")
        view.addSubview(heartbeatGraphView)
        heartbeatGraphView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(460)
        }
        //globalButton
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-175)
        }
        //pulseStack
        pulseStackView = PulseStack()
        pulseStackView.pulseLabel.text = "00"
        view.addSubview(pulseStackView)
        pulseStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(240)
            make.width.equalTo(140)
        }
        //welcomeView
        view.addSubview(welcomeView)
        welcomeView.acceptButtonAction = {
            self.hideWelcomeView()
        }
        welcomeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(330)

        }
        //cameraView
        view.addSubview(cameraView)
        cameraView.okButtonAction = {
            self.hideCameraView()
        }
        cameraView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(330)
        }
        //progressBar
        progressBar.setProgress(to: 0.001)
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.centerX.equalTo(view).offset(0)
            make.top.equalTo(view).offset(275)
        }
    }
    
    @objc func startTapped() {
        if UserDefaults.standard.bool(forKey: "userEnteringApp") {
            print("Пользователь уже вошел - startTapped")
            
            currentProgress = 0.0 // Сброс текущего прогресса
            progressBar.setProgress(to: currentProgress)
            progressTimer?.invalidate()
            progressTimer = Timer.scheduledTimer(timeInterval: 0.00001,
                                                 target: self,
                                                 selector: #selector(updateProgressBar),
                                                 userInfo: nil, repeats: true)

            
            if let coreData = CoreDataeManager.shared.fetchProfile(){
                // Распечатываем данные пользователя
                print("-----------------")
                print("Выбранные единицы измерения: \(coreData.units ?? "Не указаны")")
                print("Пол: \(coreData.gender ?? "Не указан")")
                print("Рост: \(coreData.height)")
                print("Вес: \(coreData.weight)")
                print("Возраст: \(coreData.age)")
                print("-----------------")
            }
            
            
            //settings start measure func this
            startMeasurePulseView()
        } else {
            print("Первый раз вошел - startTapped")
            UserDefaults.standard.set(true, forKey: "userEnteringApp")
            openAboutVC()
        }

    }
    //обновления прогресса
    @objc func updateProgressBar() {
        if currentProgress < 1.0 {
            currentProgress += 0.000003
            progressBar.setProgress(to: currentProgress)
        } else {
            progressTimer?.invalidate() // Останавливаем таймер, если прогресс достиг 1
        }
    }
}

extension PulseViewController {

    // MARK: - Navigation
    func openAnalyzeVC(){
        let analyzi = AnalyzViewController()
        analyzi.modalPresentationStyle = .fullScreen
        analyzi.modalTransitionStyle = .crossDissolve
        present(analyzi, animated: true, completion: nil)
    }
    
    func openAboutVC(){
        let aboutVC = AboutMeViewController()
        aboutVC.delegate = self
        aboutVC.modalPresentationStyle = .fullScreen
        aboutVC.modalTransitionStyle = .crossDissolve
        present(aboutVC, animated: true, completion: nil)
    }
    // Метод для скрытия WelcomeView
    func hideWelcomeView() {
        tabBarController?.tabBar.isHidden = false
        welcomeView.isHidden = true
        dimmy.isHidden = true
        dimmy.removeFromSuperview()
    }
    // Метод для отображения WelcomeView
    func showWelcomeView() {
        tabBarController?.tabBar.isHidden = true
        welcomeView.isHidden = false
        
        view.addSubview(dimmy)
        dimmy.isHidden = false
        dimmy.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(welcomeView)
        welcomeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(320)
        }
    }
    
    // Метод для скрытия CameraAccessView
    func hideCameraView() {
        tabBarController?.tabBar.isHidden = false
        cameraView.isHidden = true
        dimmy.isHidden = true
        dimmy.removeFromSuperview()
    }

    // Метод для отображения CameraAccessView
    func showCameraView(){
        tabBarController?.tabBar.isHidden = true
        cameraView.isHidden = false
        
        view.addSubview(dimmy)
        dimmy.isHidden = false
        dimmy.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(cameraView)
        cameraView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(320)
        }
    }
    
    func startMeasurePulseView(){
        fingerOnCameraGuide.isHidden = false
        heartbeatGraphView.isHidden = true
        startButton.isHidden = true
        cameraFingerGuideText.isHidden = false
        
    
    }
    
    func endMeasurePulseView(){
        fingerOnCameraGuide.isHidden = true
        heartbeatGraphView.isHidden = false
        startButton.isHidden = false
        cameraFingerGuideText.isHidden = true
    }
}

extension PulseViewController: AboutMeViewControllerDelegate {
    func didCloseAboutScreen() {
        showCameraView()
    }
}
