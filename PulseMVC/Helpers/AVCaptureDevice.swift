//
//  AVCaptureDevice.swift
//  PulseMVC
//
//  Created by vlad zarya on 29.03.24.
//

import Foundation
import AVFoundation

extension AVCaptureDevice {
    // Метод для получения доступных форматов с заданным предпочтительным FPS
    private func availableFormatsFor(preferredFps: Float64) -> [AVCaptureDevice.Format] {
        var availableFormats: [AVCaptureDevice.Format] = []
        for format in formats {
            let ranges = format.videoSupportedFrameRateRanges
            for range in ranges where range.minFrameRate <= preferredFps && preferredFps <= range.maxFrameRate {
                availableFormats.append(format)
            }
        }
        return availableFormats
    }
    
    // Метод для выбора формата с наивысшим разрешением из доступных форматов
    private func formatWithHighestResolution(_ availableFormats: [AVCaptureDevice.Format]) -> AVCaptureDevice.Format? {
        var maxWidth: Int32 = 0
        var selectedFormat: AVCaptureDevice.Format?
        for format in availableFormats {
            let desc = format.formatDescription
            let dimensions = CMVideoFormatDescriptionGetDimensions(desc)
            let width = dimensions.width
            if width >= maxWidth {
                maxWidth = width
                selectedFormat = format
            }
        }
        return selectedFormat
    }

    // Метод для выбора формата с заданным размером из доступных форматов
    private func formatFor(preferredSize: CGSize, availableFormats: [AVCaptureDevice.Format]) -> AVCaptureDevice.Format? {
        for format in availableFormats {
            let desc = format.formatDescription
            let dimensions = CMVideoFormatDescriptionGetDimensions(desc)
            
            if dimensions.width >= Int32(preferredSize.width) && dimensions.height >= Int32(preferredSize.height) {
                return format
            }
        }
        return nil
    }
    
    // Метод для обновления формата видео с учетом предпочтительных характеристик
    func updateFormatWithPreferredVideoSpec(preferredSpec: VideoSpec) {
        let availableFormats: [AVCaptureDevice.Format]
        if let preferredFps = preferredSpec.fps {
            availableFormats = availableFormatsFor(preferredFps: Float64(preferredFps))
        } else {
            availableFormats = formats
        }
        
        var selectedFormat: AVCaptureDevice.Format?
        if let preferredSize = preferredSpec.size {
            selectedFormat = formatFor(preferredSize: preferredSize, availableFormats: availableFormats)
        } else {
            selectedFormat = formatWithHighestResolution(availableFormats)
        }
        print("selected format: \(String(describing: selectedFormat))")
        
        if let selectedFormat = selectedFormat {
            do {
                try lockForConfiguration()
            } catch let error {
                fatalError(error.localizedDescription)
            }
            
            // Установка активного формата
            activeFormat = selectedFormat
            
            if let preferredFps = preferredSpec.fps {
                // Установка активного FPS
                activeVideoMinFrameDuration = CMTimeMake(value: 1, timescale: preferredFps)
                activeVideoMaxFrameDuration = CMTimeMake(value: 1, timescale: preferredFps)
                unlockForConfiguration()
            }
        }
    }
    
    // Метод для включения или выключения фонарика
    func toggleTorch(on: Bool) {
        guard hasTorch, isTorchAvailable else {
            print("Torch is not available")
            return
        }
        do {
            try lockForConfiguration()
            torchMode = on ? .on : .off
            unlockForConfiguration()
        } catch {
            print("Torch could not be used \(error)")
        }
    }
}

