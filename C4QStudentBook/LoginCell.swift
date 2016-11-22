//
//  LoginCell.swift
//  C4QStudentBook
//
//  Created by Jason Wang on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class LoginCell: BaseCell, UITextFieldDelegate {

    static let identifier = "loginCellID"

    let emailTextField: UITextField = {
        let etf = UITextField()
        etf.translatesAutoresizingMaskIntoConstraints = false
        etf.placeholder = "Email address"
        etf.borderStyle = .roundedRect
        return etf
    }()

    let passwordTextField: UITextField = {
        let ptf = UITextField()
        ptf.translatesAutoresizingMaskIntoConstraints = false
        ptf.placeholder = "Password"
        ptf.isSecureTextEntry = true
        ptf.borderStyle = .roundedRect
        return ptf
    }()

    lazy var loginButton: UIButton = {
        let lib = UIButton(type: .system)
        lib.translatesAutoresizingMaskIntoConstraints = false
        lib.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        lib.setTitle("Login", for: .normal)
        lib.setTitleColor(.white, for: .normal)
        lib.backgroundColor = .orange
        return lib
    }()

    func loginButtonTapped() {
        //do stuff
        print("1 2 3 see if it works")
    }

    override func setupCell() {
        super.setupCell()
        backgroundColor = .white
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)

        emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
