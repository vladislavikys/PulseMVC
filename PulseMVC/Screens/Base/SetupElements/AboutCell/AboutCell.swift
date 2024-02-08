//
//  AboutCell.swift
//  PulseMVC
//
//  Created by Влад on 6.02.24.
//

import UIKit

final class AboutCell: UICollectionViewCell{
    
    var nameCell = "" {
        didSet {
            warningLabel.text = "Please enter a valid value for : \(nameCell)"
        }
    }
    
    var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    var warningLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    var addButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action: #selector(addButtonTapper), for: .touchUpInside)
        return button
    }()
    
    var textField: UITextField = {
        let tf = UITextField()
        tf.isHidden = true
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        tf.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    var isTextFieldVisible: Bool = false {
        didSet{
            //если true то кнопка скрыта показываем textfield
            //если false то textfield скрыта показываем button plus
            addButton.isHidden = isTextFieldVisible
            textField.isHidden = !isTextFieldVisible
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //настраиваем label ячейки 
    func configTitleLabel(with title: String){
        self.titleLabel.text = title
    }
    
    private func setupCell(){
        
        backgroundColor = AppColor.aboutCellBack.color.withAlphaComponent(0.6)
        
        textField.inputAccessoryView = createDoneButtonToolbar()
        textField.delegate = self
        
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = AppColor.strokeCell.color.cgColor
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(16)
            make.centerY.equalToSuperview()
        }
        
        addSubview(warningLabel)
        warningLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(16)
        }
        
        
        addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(14)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    //добавили на клаву готово
    private func createDoneButtonToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
    
    @objc func addButtonTapper(){
        print("Add button tepped ")
        isTextFieldVisible = true
        textField.becomeFirstResponder()
    }
    
    //ограничение на 3 символа в textField
    //target textField
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 3 {
            textField.deleteBackward()
        }
    }
    
    //скрываем клаву и убираем выделение textfield
    @objc func doneButtonTapped() {
        textField.resignFirstResponder()
        
        if textField.text?.isEmpty ?? true {
            isTextFieldVisible = false
            addButton.setImage(UIImage(named: "redAdd"), for: .normal)
            warningLabel.isHidden = false
            animateTitleLabelUp()
        } else {
            warningLabel.isHidden = true
            animateTitleLabelDown()
        }
    }
}

extension AboutCell: UITextFieldDelegate {
    
    //создаем набор разрешенный символов = только цифрам
    //проверяем в строке находятся только разрешенный символы то true
    //иначе воо дне будет работатть
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedChar = CharacterSet.decimalDigits
        let charSet = CharacterSet(charactersIn: string)
        return allowedChar.isSuperset(of: charSet)
    }
}

extension AboutCell {
    func animateTitleLabelUp() {
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-8)
            }
            self.layoutIfNeeded()
        }
    }

    func animateTitleLabelDown() {
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.snp.updateConstraints { make in
                make.centerY.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }

}

