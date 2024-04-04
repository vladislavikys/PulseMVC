//
//  AnalyzViewController.swift
//  PulseMVC
//
//  Created by vlad zarya on 16.03.24.
//

import UIKit

protocol AnalyzViewControllerDelegate: AnyObject {
    func didTapContinue()
}

class AnalyzViewController: BaseViewController {
    
    weak var delegate: AnalyzViewControllerDelegate?
    
    
    private var globalButton = GlobalButton()
    private var text = UITextView()
    private var stackH = StackH()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        stackH.delegate = self
        titleLabel.text = "Analyzing"
        text.text = "People have different heart rates in different states, Selecting the current state will effectively provide you with heart rate assessment analysis"
        text.backgroundColor = .clear
        text.font = .systemFont(ofSize: 16)
        text.textColor = .black
        view.addSubview(text)
        text.snp.makeConstraints{ make in
            make.leading.equalTo(view).offset(18)
            make.top.equalTo(titleLabel).offset(55)
            make.width.equalTo(320)
            make.height.equalTo(84)
        }
        //stack
        view.addSubview(stackH)
        stackH.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            // Высота  будет автоматически рассчитана от содержимого
        }
        //globalButton
        globalButton.setTitle("Continue", for: .normal)
        view.addSubview(globalButton)
        globalButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        globalButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-175)
        }
        
        
    }
    
    @objc func continueTapped() {
        dismiss(animated: true) {
            self.delegate?.didTapContinue()
            UIView.animate(withDuration: 0.3) {
                self.view.alpha = 0
            }
        }
    }
}

extension AnalyzViewController: StackHDelegate {
    func didSelectActivityView(named imageName: String) {
            CoreDataeManager.shared.updateProfile(analyze: imageName)
        }
}
