import UIKit
import CoreData
import AVKit

class PulseViewController: BaseViewController {
    private var buttonInfo = UIButton()
    private var pulseStatusLabel = UILabel()
    private var underRingLabel = UILabel()
    private var fingerOnCameraGuide = UIImageView()
    private var cameraFingerGuideText = UILabel()
    private var heartbeatGraphView = UIImageView()
    
    private var startButton = GlobalButton()
//    private var progressBar = MyProgressBar()
    private var progressBar = VadimProgressCopyLogic()
    private var pulseStackView = PulseStack()
    
    private var welcomeView = WelcomeView()
    private var resultView = ResultView()
    private var cameraView = CameraAccessView()
    var dimmy = DimmyView()
    var userProfile = AboutModel()
    
    //таймер для прогресса
    private var progressTimer: Timer?
    private var currentProgress: CGFloat = 0.0
    
    // Менеджеры для работы с измерением пульса
    var hueFilter = Filter() // Фильтр для обработки изображения
    var pulseDetector = PulseDetector() // Детектор пульса
    var inputs: [CGFloat] = [] // Входные данные для детектора пульса
    var measurementStartedFlag = false // Флаг начала измерения
    var heartRateManager: HeartRateManager! // Менеджер для измерения сердечного ритма
    var bpmForCalculating: [Int] = [] // Массив для хранения значений BPM
    var validFrameCounter = 0 // Счетчик валидных кадров
    var timer = Timer() // Таймер
    var timerTwo = Timer() // Второй таймер
    var viewModel = HeartRateModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCheckPayWall()
        setupUI()
        fingerOnCameraGuide.isHidden = true
        hideView()
        displayCheckWelcomeView()
    }
    
    func setupUI() {
        view.addSubview(buttonInfo)
        view.addSubview(pulseStatusLabel)
        view.addSubview(cameraFingerGuideText)
        view.addSubview(fingerOnCameraGuide)
        view.addSubview(heartbeatGraphView)
        view.addSubview(startButton)
        view.addSubview(pulseStackView)
        view.addSubview(welcomeView)
        view.addSubview(cameraView)
        view.addSubview(resultView)
        view.addSubview(progressBar)
        
        //buttonInfo
        buttonInfo.setImage(UIImage(named: "buttonInfo"), for: .normal)
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
        pulseStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(125)
            make.centerX.equalTo(view)
        }
        
        //cameraFingerGuideText
        cameraFingerGuideText.isHidden = true
        cameraFingerGuideText.text = "Place your finger on the back camera and flashlight"
        cameraFingerGuideText.textAlignment = .center
        cameraFingerGuideText.numberOfLines = 2
        cameraFingerGuideText.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(460)
            make.leading.equalTo(view).offset(55)
            make.trailing.equalTo(view).offset(-55)
        }
        
        //fingerOnCameraGuide
        fingerOnCameraGuide.image = UIImage(named: "fingerOnCameraGuide")
        fingerOnCameraGuide.snp.makeConstraints { make in
            make.top.equalTo(560)
            make.centerX.equalTo(view)
        }
        
        //heartbeatGraphView
        heartbeatGraphView.image = UIImage(named: "heartbeat")
        heartbeatGraphView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(430)
        }
        //globalButton
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-175)
        }
        //pulseStack
       
        pulseStackView.pulseLabel.text = "00"
        pulseStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(240)
            make.width.equalTo(140)
        }
        //welcomeView
        welcomeView.acceptButtonAction = {
            self.hideWelcomeView()
        }
        welcomeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(330)
        }
        //cameraView
        cameraView.okButtonAction = {
            self.hideCameraView()
        }
        cameraView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(330)
        }
        //resultView
        resultView.acceptButtonAction = {
            self.hideResultView()
        }
        resultView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(630)
        }
        //progressBar
        progressBar.setupProgressBar(type: true)
        progressBar.snp.makeConstraints { make in
            make.centerX.equalTo(view).offset(0)
            make.top.equalTo(view).offset(275)
        }
    }
    
    @objc func startTapped() {
        if UserDefaults.standard.bool(forKey: "userEnteringApp") {
            print("Пользователь уже вошел - startTapped")
            printDB()
            startPulseHeartRate()
        } else {
            print("Первый раз вошел - startTapped")
            UserDefaults.standard.set(true, forKey: "userEnteringApp")
            openAboutVC()
        }
    }
}

extension PulseViewController {
    func hideView(){
        hideWelcomeView()
        hideCameraView()
        hideResultView()
    }
    func openPayWallVC(){
        let payWall = PayWallController()
        payWall.modalPresentationStyle = .fullScreen
        payWall.modalTransitionStyle = .crossDissolve
        present(payWall, animated: true, completion: nil)
    }
    func displayCheckPayWall(){
        if UserDefaults.standard.bool(forKey: "userEnteringPayWall"){
            print("БОЛЬШЕ НЕ ПОКАЗЫВАЕМ paywall")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.openPayWallVC()
            }
        }
    }
    
    func displayCheckWelcomeView(){
        if UserDefaults.standard.bool(forKey: "userEnteringWelcom") {
            print("пользователь уже вхоли -viewDidLoad ")
            hideWelcomeView()
        } else {
            print("первый раз вощелЭ - viewDidLoad")
            showWelcomeView()
        }
    }
    // MARK: - Navigation
    func openAnalyzeVC(){
        let analyzi = AnalyzViewController()
        analyzi.delegate = self
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
     //Метод для скрытия WelcomeView
    func hideWelcomeView() {
        tabBarController?.tabBar.isHidden = false
        welcomeView.isHidden = true
        dimmy.isHidden = true
        dimmy.removeFromSuperview()
    }
     //Метод для отображения WelcomeView
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
    func hideResultView() {
        tabBarController?.tabBar.isHidden = false
        resultView.isHidden = true
        dimmy.isHidden = true
        dimmy.removeFromSuperview()
    }
    func showResultView() {
        let coreData = CoreDataeManager.shared.fetchProfile()
        let bpm = Int(coreData?.bpm ?? 0)
        let nameEmoji = coreData?.analyze ?? "coffeeEmoji"
        
        tabBarController?.tabBar.isHidden = true
        
        resultView.activityView.setImage(named: nameEmoji)
    
        
        //если пульс выше 120 статус меняется на bad pulse
        resultView.stackHeart.pulseLabel.text = String(coreData!.bpm)
        if bpm < 120{
            resultView.statusPulse.setPulseStatus(.normal)
        } else {
            resultView.statusPulse.setPulseStatus(.bad)
        }
        
        resultView.isHidden = false
        dimmy.isHidden = false
        
        view.addSubview(dimmy)
        view.addSubview(resultView)
        
        
        dimmy.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        resultView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(520)
        }
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

extension PulseViewController: AnalyzViewControllerDelegate {
    func didTapContinue() {
        showResultView()
    }
}

extension PulseViewController {
    private func reqCameraPermiss(){
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Camera Access ",
                                          message: "Please enable camera access in your device settings.",
                                          preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
    private func startPulseHeartRate() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                fingerOnCameraGuide.isHidden = false
                heartbeatGraphView.isHidden = true
                startButton.isHidden = true
                cameraFingerGuideText.isHidden = false
                pulseStatusLabel.text = "20 seconds remaining"
                print("START PULSE MEASURE")
                initStartPulse()
            }
        } else {
            // Если разрешение на использование камеры не получено,
            //показать алерт на получение разрешения камеры
            reqCameraPermiss()
        }
    }
    
    // Инициализирует процесс захвата видео для начала измерения пульса.
    private func initStartPulse() {
        // Инициализация захвата видео и сессии захвата.
        initVideoCapture()
        initCaptureSession()
    }
    
    // Инициализация захвата видео с камеры.
    func initVideoCapture() {
        // Задаем характеристики захвата видео.
        let specs = VideoSpec(fps: 60, size: CGSize(width: 50, height: 50))
        // Инициализация менеджера сердечного ритма с выбранной камерой и характеристиками.
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: CAShapeLayer())
        // Обработчик получаемых изображений.
        heartRateManager.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)
        }
    }
    
    // Начало сессии захвата видео.
    func initCaptureSession() {
        heartRateManager.startCapture()
    }
    
    // Завершение сессии захвата видео.
    func deinitCaptureSession() {
        if heartRateManager != nil {
            heartRateManager.stopCapture()
            toggleTorch(status: false)
        }
    }
    
    // Включение или выключение вспышки.
    func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }
    
    // Начало процесса измерения пульса.
    func startMeasurement() {
        DispatchQueue.main.async { [unowned self] in
            var count = 20
            self.bpmForCalculating.removeAll()
            self.toggleTorch(status: true)
            
            //self.progressBar.setProgress(to: 1, duration: 20)
            self.progressBar.animationProgress(duration: 20)
            
            // Таймер для обновления интерфейса и расчета пульса.
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
                guard let self = self else { return }
                
                // Логика работы таймера.
                if count > 0 {
                    count -= 1
                    let average = self.pulseDetector.getAverage()
                    let pulse = 60.0/average
                    print("pulse: \(pulse)")
                    print(bpmForCalculating)
                    self.pulseStatusLabel.text = "\(count) seconds remaining"
                    // Проверка пульса и обновление данных.
                    if pulse != -60 {
                        self.pulseStackView.pulseLabel.text = "\(lroundf(pulse))"
                        self.bpmForCalculating.append(Int(pulse))
                    }
                } else {
                    // Действия по завершении измерения.
                    if self.bpmForCalculating != [] {
                        print("// Действия по завершении измерения.")
                        viewModel.calculatingAndSaveToDBBpmData(pulse: self.bpmForCalculating)
                        //self.progressBar.removeAnimation()
                        self.progressBar.deleteAnimations()
                    }
                    self.defaultState()
                    printDB()
                    openAnalyzeVC()
                }
            })
        }
    }
    
    // Установка состояния по умолчанию для UI элементов.
    func defaultState() {
        tabBarController?.tabBar.isHidden = false
        self.startButton.isHidden = false
        self.pulseStackView.isHidden = false
        self.buttonInfo.isHidden = false
        self.cameraFingerGuideText.isHidden = true
        self.fingerOnCameraGuide.isHidden = true
        self.heartbeatGraphView.isHidden = false
        self.pulseStatusLabel.text = "No finger"
        self.toggleTorch(status: false)
        self.heartRateManager.stopCapture()
        timer.invalidate()
    }
    
    // Обработка захваченного видео для измерения пульса.
    func handle(buffer: CMSampleBuffer) {
        var redmean:CGFloat = 0.0
        var greenmean:CGFloat = 0.0
        var bluemean:CGFloat = 0.0
        
        // Получение изображения из буфера и преобразование его в цветовые значения.
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)
        
        // Вычисление среднего значения цвета пикселей.
        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                                     parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!
        
        let ctx = CIContext(options:nil)
        let cgImage = ctx.createCGImage(outputImage, from:outputImage.extent)!
        
        let rawData:NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start:pixels, count:rawData.length)
        var BGRA_index = 0
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch BGRA_index {
            case 0:
                bluemean = CGFloat (pixel)
            case 1:
                greenmean = CGFloat (pixel)
            case 2:
                redmean = CGFloat (pixel)
            case 3:
                break
            default:
                break
            }
            BGRA_index += 1
        }
        // Преобразование цветового пространства из RGB в HSV
        let hsv = rgb2hsv((red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        
        // Проверяем, что над камерой находится палец или что-то подобное
        if (hsv.1 > 0.5 && hsv.2 > 0.5) {
            // Выполняем операции на главной очереди асинхронно
            DispatchQueue.main.async {
                // Включаем фонарик, если он не включен
                self.toggleTorch(status: true)
                // Если измерение пульса еще не начато, запускаем его
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            // Увеличиваем счетчик валидных кадров
            validFrameCounter += 1
            // Добавляем значение тона в массив
            inputs.append(hsv.0)
            // Фильтруем значение тона
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            // Если количество валидных кадров больше 60, добавляем значение в анализатор пульса
            if validFrameCounter > 60 {
                _ = self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            // Отключаем таймер
            self.timer.invalidate()
            // Сбрасываем счетчик валидных кадров, флаг и анализатор пульса
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            // Выполняем операции на главной очереди
            DispatchQueue.main.async {
                // Останавливаем анимацию пульса и сердцебиения
                //self.stopAnimationPulse()
                //self.stopAnimationHeartBeat()
                self.pulseStackView.pulseLabel.text = "00"
                // Удаляем анимации прогресса
                //self.progressBar.removeAnimation()
                self.progressBar.deleteAnimations()
            }
        }
    }
}
