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
    private var pulseStack = PulseStack()
    private var customStackView: UIStackView?
    
    //test func
    let changePulse = UIButton()
    var pulse = "00"


    
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
            make.top.equalTo(380)
            
        }
        
        //globalButton
        view.addSubview(globalButton)
        globalButton.addTarget(self, action: #selector(startTappeed), for: .touchUpInside)
        globalButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-100)
            
        }
        //pulseStack
        customStackView = PulseStack.createCustomHorizStackView(pulse: pulse)
        if let customStackView = customStackView{
            view.addSubview(customStackView)
            customStackView.snp.makeConstraints { make in
                make.centerX.equalTo(view)
                make.top.equalTo(view).offset(240)
            }
        }
        //testButton
        changePulse.backgroundColor = .red
        changePulse.addTarget(self, action: #selector(changePulses), for: .touchUpInside)
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
    
    @objc func changePulses(){
        var current = 0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if current <= 210 {
                self.pulse = "\(current)"
                current += 7
                self.updateCustomStackView()
            }else{
                timer.invalidate()
            }
        }
    }
    
    func updateCustomStackView(){
        customStackView?.removeFromSuperview()
        
        customStackView = PulseStack.createCustomHorizStackView(pulse: self.pulse)
        
        if let customStackView = customStackView{
            self.view.addSubview(customStackView)
            customStackView.snp.makeConstraints { make in
                make.centerX.equalTo(self.view)
                make.top.equalTo(self.view).offset(240)
            }
        }
    }
}

