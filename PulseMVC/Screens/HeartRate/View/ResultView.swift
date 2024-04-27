//
//  ResultView.swift
//  PulseMVC
//
//  Created by vlad zarya on 26.03.24.
//

import UIKit

enum PulseStatus {
    case normal
    case bad
}

class ResultView: UIView {
    
    var acceptButtonAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        label.text = "Result"
        return label
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy, hh:mm a"
        return formatter
    }()
    
    private let dateTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.text = "February 66 9999, 25:64 AM"
        return label
    }()
    
     let stackHeart = StackResultH()
     let statusPulse = StatusPulseView()
    let activityView = ActivityView(frame: CGRect.zero, emojiSize: 24)
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.text = "Heart rate Tips"
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Many lifestyle habits can maintain a healthy heart rate, and a healthy diet helps to keep your heart rate slow for a long time. Eat more vegetables and fruits, and eat less foods high in fat and cholesterol."
        return label
    }()
    
    private let acceptButton: GlobalButton = {
        let button = GlobalButton()
        button.setTitle("OK", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        updateTime()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        updateTime()
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 24
        
        addSubview(titleLabel)
        addSubview(stackHeart)
        addSubview(activityView)
        addSubview(infoLabel)
        addSubview(acceptButton)
        addSubview(headerTitle)
        addSubview(statusPulse)
        addSubview(dateTitle)
        
        dateTitle.snp.makeConstraints { make in
            make.leading.left.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        stackHeart.snp.makeConstraints { make in
            make.top.equalTo(dateTitle.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        activityView.layer.cornerRadius = 20
        activityView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.height.width.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        statusPulse.setPulseStatus(.normal)
        statusPulse.snp.makeConstraints { make in
            make.bottom.equalTo(headerTitle.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(110)
        }
        
        headerTitle.textAlignment = .left
        headerTitle.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(acceptButton.snp.top).offset(-60)
            make.width.equalToSuperview().inset(20)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        acceptButton.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
    }
    
    @objc private func updateTime() {
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        dateTitle.text = formattedDate
        
        // Обновляем время каждую минуту
        Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTime), userInfo: nil, repeats: false)
    }
    
    @objc private func acceptButtonTapped() {
        self.isHidden = true
        acceptButtonAction?()
    }
}


