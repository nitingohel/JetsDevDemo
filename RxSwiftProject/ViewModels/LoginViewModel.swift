//
//  LoginViewModel.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//

import UIKit
import RxSwift

class LoginViewModel: NSObject {
    var email: String?
    var password: String?
    var disposeBag: DisposeBag = DisposeBag()
    var loginView: LoginView!
    
    
    init(withView view: LoginView) {
        super.init()
        self.loginView = view
        self.loginView.updatedEmailText.subscribe { [weak self] (character) in
            self?.email = character
        }.disposed(by: self.disposeBag)
        self.loginView.updatedPasswordText.subscribe { [weak self] (character) in
            self?.password = character
        }.disposed(by: self.disposeBag)
        self.loginView.loginButton.addTarget(self, action: #selector(self.loginButtonPressed(_:)), for: .touchUpInside)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.login()
    }
    
    func login() {
        APIManager.shared.login(self.email ?? "", self.password ?? "") { (response, error) in
            print("Response: \(response)")
            if error != nil {
                self.showAlert(error?.localizedDescription ?? "")
            }
            let status = response?["result"] as? Int ?? 0
            if status == 0 {
                let error = response?["error_message"] as? String ?? ""
                self.showAlert(error)
            }
            guard let response = response , let userData = response["data"] as? Dictionary<String, Any>, let user = userData["user"] as? Dictionary<String, Any> else {
                return
            }
            let userModel = Database.shared.saveUser(user)
            print("User Model: \(userModel)" )
        }
    }
    
    func showAlert(_ messsage: String) {
        self.loginView.makeAlert?(messsage)
    }
}
