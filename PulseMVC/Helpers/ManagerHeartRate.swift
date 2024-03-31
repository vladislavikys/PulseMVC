//
//  ManagerHeartRate.swift
//  PulseMVC
//
//  Created by vlad zarya on 29.03.24.
//

import Foundation
import AVFoundation
import UIKit

// Перечисление для представления типа камеры (передняя или задняя)
enum CameraType: Int {
    case back
    case front
    
    func captureDevice() -> AVCaptureDevice {
        switch self {
        case .front:
            // Поиск устройств с передней камерой
            let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [], mediaType: AVMediaType.video, position: .front).devices
            print("devices:\(devices)")
            for device in devices where device.position == .front {
                return device
            }
        default:
            break
        }
        // Если передняя камера не найдена, используйте заднюю камеру по умолчанию
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)!
    }
}

// Структура для определения спецификаций видео
struct VideoSpec {
    var fps: Int32?
    var size: CGSize?
}

// Псевдоним типа для обработчика буфера изображения
typealias ImageBufferHandler = ((_ imageBuffer: CMSampleBuffer) -> ())

// Класс для управления обнаружением пульса
class HeartRateManager: NSObject {
    private let captureSession = AVCaptureSession()
    private var videoDevice: AVCaptureDevice!
    private var videoConnection: AVCaptureConnection!
    private var previewLayer: AVCaptureVideoPreviewLayer?
    var errorCompletion: (() -> ())?
    var imageBufferHandler: ImageBufferHandler?
    
    // Инициализация с заданным типом камеры, предпочтительными характеристиками видео и контейнером для предпросмотра
    init(cameraType: CameraType, preferredSpec: VideoSpec?, previewContainer: CALayer?) {
        super.init()
        videoDevice = cameraType.captureDevice()
        
        // MARK: - Настройка формата видео
        do {
            captureSession.sessionPreset = .low
            if let preferredSpec = preferredSpec {
                // Обновление формата с предпочтительным FPS
                videoDevice.updateFormatWithPreferredVideoSpec(preferredSpec: preferredSpec)
            }
        }
        
        // MARK: - Настройка входного устройства видео
        let videoDeviceInput: AVCaptureDeviceInput
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch  {
            // MARK: - ОБРАБОТКА ОШИБКИ, ЕСЛИ ПОЛЬЗОВАТЕЛЬ НЕ РАЗРЕШИЛ ДОСТУП К КАМЕРЕ
            //errorCompletion?()
            fatalError("Не удалось создать экземпляр AVCaptureDeviceInput с ошибкой: \(error).")
        }
        guard captureSession.canAddInput(videoDeviceInput) else { fatalError() }
        captureSession.addInput(videoDeviceInput)
        
        // MARK: - Настройка слоя предпросмотра
        if let previewContainer = previewContainer {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = previewContainer.bounds
            previewLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            previewContainer.insertSublayer(previewLayer, at: 0)
            self.previewLayer = previewLayer
        }
        
        // MARK: - Настройка вывода видео
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue(label: "com.covidsense.videosamplequeue")
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        guard captureSession.canAddOutput(videoDataOutput) else {
            fatalError()
        }
        captureSession.addOutput(videoDataOutput)
        videoConnection = videoDataOutput.connection(with: .video)
    }
    
    // Запуск захвата видео
    func startCapture() {
        #if DEBUG
        print(#function + "\(self.classForCoder)/")
        #endif
        if captureSession.isRunning {
            #if DEBUG
            print("Сессия захвата уже запущена 🏃‍♂️.")
            #endif
            return
        }
        captureSession.startRunning()
    }
    
    // Остановка захвата видео
    func stopCapture() {
        #if DEBUG
        print(#function + "\(self.classForCoder)/")
        #endif
        if !captureSession.isRunning {
            #if DEBUG
            print("Сессия захвата уже остановлена 🛑.")
            #endif
            return
        }
        captureSession.stopRunning()
    }
}

extension HeartRateManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    // MARK: - Экспорт буфера изображения из видеокадра
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection.videoOrientation != .portrait {
            connection.videoOrientation = .portrait
            return
        }
        if let imageBufferHandler = imageBufferHandler {
            imageBufferHandler(sampleBuffer)
        }
    }
}


