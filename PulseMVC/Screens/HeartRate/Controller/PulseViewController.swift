//
//  PulseViewController.swift
//  PulseMVC
//
//  Created by Влад on 1.02.24.
//

import UIKit

class PulseViewController: BaseViewController {
    
    private var buttonInfo = UIButton()
    private var pulseStatusLabel = UILabel()
    private var underRingLabel = UILabel()
    private var fingerOnCameraGuide = UIImageView()
    private var heartbeatGraphView = UIImageView()
    
    
    private var globalButton = GlobalButton()
    private var progressBar = ProgressBar()
    private var pulseStackView: PulseStack!
    
    //test func
    let changePulse = UIButton()
    private var timer : Timer?
    private var currentPulsse = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupProgressBar()
        
        fingerOnCameraGuide.isHidden = true
    }
}

extension PulseViewController{
    func setupUI(){
        //buttonInfo
        buttonInfo.setImage(UIImage(named: "buttonInfo"), for: .normal)
        view.addSubview(buttonInfo)
        buttonInfo.snp.makeConstraints {make in
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
        
        //fingerOnCameraGuide
        fingerOnCameraGuide.image = UIImage(named: "fingerOnCameraGuide")
        view.addSubview(fingerOnCameraGuide)
        fingerOnCameraGuide.snp.makeConstraints { make in
            make.top.equalTo(480)
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
        view.addSubview(globalButton)
        globalButton.addTarget(self, action: #selector(startTappeed), for: .touchUpInside)
        globalButton.snp.makeConstraints { make in
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
        
        
        
        //testButton
        changePulse.backgroundColor = .red
        changePulse.addTarget(self, action: #selector(startPulseSimulation), for: .touchUpInside)
        view.addSubview(changePulse)
        changePulse.snp.makeConstraints { make in
            make.top.equalTo(view).offset(78)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-35)
            make.width.height.equalTo(24)
        }
    }
    
    private func setupProgressBar(){
        //progressBar
        progressBar = ProgressBar(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.centerX.equalTo(view).offset(-90)
            make.top.equalTo(view).offset(185)
        }
    }
    
    @objc func startTappeed(){
        let aboutVC = AboutMeViewController()
        aboutVC.modalPresentationStyle = .fullScreen
        aboutVC.modalTransitionStyle = .crossDissolve
        present(aboutVC, animated: true, completion: nil)
    }
    
}

extension PulseViewController {
    @objc func startPulseSimulation() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePulseLabel), userInfo: nil, repeats: true)
    }
    @objc func updatePulseLabel() {
        pulseStackView.pulseLabel.text = "\(currentPulsse)"
        currentPulsse += 3
        if currentPulsse > 140{
            timer?.invalidate()
        }
    }
}


