//
//  ViewController.swift
//  RxSwiftProject
//
//  Created by Nitin Gohel on 01/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addLoginView()
    }

    func addLoginView() {
        let nib = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
        if let loginView = nib?.first as? LoginView {
            self.view.addSubview(loginView)
            loginView.translatesAutoresizingMaskIntoConstraints = false
            loginView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            loginView.makeAlert = { message in
                self.showAlert(message)
            }
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { (action) in
            
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

