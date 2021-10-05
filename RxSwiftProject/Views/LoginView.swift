//
//  LoginView.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//

import UIKit
import RxSwift

class LoginView: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    private var emailText = PublishSubject<String>()
    var updatedEmailText: Observable<String> {
        return emailText.asObservable()
    }
    
    private var passwordText = PublishSubject<String>()
    var updatedPasswordText: Observable<String> {
        return passwordText.asObservable()
    }
    
    var loginModel: LoginViewModel!
    var makeAlert: ((String) -> Void)?
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.loginModel = LoginViewModel(withView: self)
        self.setupUI()
    }
    
    func setupUI() {
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.clipsToBounds = true
        self.loginButton.isEnabled = false
        self.emailErrorLabel.isHidden = true
        self.passwordErrorLabel.isHidden = true
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            self.checkValidation(textField, updatedText)
            if textField == self.passwordTextField {
                return updatedText.count <= 16
            }
        }
        return true
    }
    
    func checkValidation(_ textField: UITextField, _ text: String) {
        if textField == self.emailTextField {
            self.emailErrorLabel.isHidden = self.checkEmailValidation(text)
            self.emailText.onNext(text)
        }
        if textField == self.passwordTextField {
            self.passwordErrorLabel.isHidden = self.checkPasswordValidation(text)
            self.passwordText.onNext(text)
        }
        self.loginButton.isEnabled = self.emailErrorLabel.isHidden && self.passwordErrorLabel.isHidden
    }
    
    func checkPasswordValidation(_ text: String) -> Bool {
        let passwordPattern = #"(?=.{8,16})"# + #"(?=.*[A-Z])"# + #"(?=.*[a-z])"# + #"(?=.*\d)"#
        let result = (text).range(of: passwordPattern, options: .regularExpression, range: nil, locale: nil)
        let validPassword = (result != nil)
        return validPassword
    }
    
    func checkEmailValidation(_ text: String) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = (text).range(of: emailPattern, options: .regularExpression, range: nil, locale: nil)
        let validEmail = (result != nil)
        return validEmail
    }
}
