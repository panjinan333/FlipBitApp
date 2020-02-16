//
//  ATCSignUpScreenManager.swift
//  DashboardApp
//
//  Created by Florian Marcu on 8/10/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import FirebaseAuth
import UIKit

protocol ATCSignUpScreenManagerDelegate: class {
    func signUpManagerDidCompleteSignUp(_ signUpManager: ATCSignUpScreenManager, user: ATCUser?)
}

class ATCSignUpScreenManager: ATCSignUpScreenDelegate {
    let signUpScreen: ATCSignUpScreenProtocol
    let viewModel: SignUpScreenViewModel
    let uiConfig: OnboardingConfigurationProtocol
    let serverConfig: ATCOnboardingServerConfigurationProtocol
    let firebaseLoginManager: ATCFirebaseLoginManager?

    weak var delegate: ATCSignUpScreenManagerDelegate?

    init(signUpScreen: ATCSignUpScreenProtocol,
         viewModel: SignUpScreenViewModel,
         uiConfig: OnboardingConfigurationProtocol,
         serverConfig: ATCOnboardingServerConfigurationProtocol) {
        self.signUpScreen = signUpScreen
        self.viewModel = viewModel
        self.uiConfig = uiConfig
        self.serverConfig = serverConfig
        self.firebaseLoginManager = serverConfig.isFirebaseAuthEnabled ? ATCFirebaseLoginManager() : nil
    }

    func signUpScreenDidLoadView(_ signUpScreen: ATCSignUpScreenProtocol) {
        if let titleLabel = signUpScreen.titleLabel {
            titleLabel.font = uiConfig.titleFont
            titleLabel.text = viewModel.title
            titleLabel.textColor = uiConfig.titleColor
        }

        if let nameField = signUpScreen.nameTextField {
            nameField.configure(color: uiConfig.textFieldColor,
                                font: uiConfig.signUpTextFieldFont,
                                cornerRadius: 40/2,
                                borderColor: uiConfig.textFieldBorderColor,
                                backgroundColor: uiConfig.textFieldBackgroundColor,
                                borderWidth: 1.0)
            nameField.placeholder = viewModel.nameField
            nameField.clipsToBounds = true
        }

        if let emailField = signUpScreen.emailTextField {
            emailField.configure(color: uiConfig.textFieldColor,
                                font: uiConfig.signUpTextFieldFont,
                                cornerRadius: 40/2,
                                borderColor: uiConfig.textFieldBorderColor,
                                backgroundColor: uiConfig.textFieldBackgroundColor,
                                borderWidth: 1.0)
            emailField.placeholder = viewModel.emailField
            emailField.clipsToBounds = true
        }

        if let phoneNumberTextField = signUpScreen.phoneNumberTextField {
            phoneNumberTextField.configure(color: uiConfig.textFieldColor,
                                           font: uiConfig.signUpTextFieldFont,
                                           cornerRadius: 40/2,
                                           borderColor: uiConfig.textFieldBorderColor,
                                           backgroundColor: uiConfig.textFieldBackgroundColor,
                                           borderWidth: 1.0)
            phoneNumberTextField.placeholder = viewModel.phoneField
            phoneNumberTextField.clipsToBounds = true
        }

        if let passwordField = signUpScreen.passwordTextField {
            passwordField.configure(color: uiConfig.textFieldColor,
                                    font: uiConfig.signUpTextFieldFont,
                                    cornerRadius: 40/2,
                                    borderColor: uiConfig.textFieldBorderColor,
                                    backgroundColor: uiConfig.textFieldBackgroundColor,
                                    borderWidth: 1.0)
            passwordField.placeholder = viewModel.passwordField
            passwordField.isSecureTextEntry = true
            passwordField.clipsToBounds = true
        }

        if let signUpButton = signUpScreen.signUpButton {
            signUpButton.setTitle(viewModel.signUpString, for: .normal)
            signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
            signUpButton.configure(color: uiConfig.loginButtonTextColor,
                                     font: uiConfig.signUpScreenButtonFont,
                                     cornerRadius: 40/2,
                                     backgroundColor: UIColor(hexString: "#334D92"))
        }
    }

    @objc func didTapSignUpButton() {
        if serverConfig.isFirebaseAuthEnabled {
            if let email = signUpScreen.emailTextField.text,
                let password = signUpScreen.passwordTextField.text,
                let firstName = signUpScreen.nameTextField.text {
                if (!isValid(email: email, pass: password, firstName: firstName)) {
                    return
                }
                let hud = CPKProgressHUD.progressHUD(style: .loading(text: "Loading"))
                hud.show(in: signUpScreen.view)
                Auth.auth().createUser(withEmail: email, password: password) {[weak self] (authResult, error) in
                    hud.dismiss()
                    if let user = authResult?.user {
                        if let strongSelf = self {
                            let atcUser = ATCUser(uid: user.uid,
                                                  firstName: user.displayName ?? strongSelf.signUpScreen.nameTextField.text ?? "",
                                                  lastName: "",
                                                  avatarURL: user.photoURL?.absoluteString ?? "",
                                                  email: user.email ?? "")
                            strongSelf.firebaseLoginManager?.saveUserToServerIfNeeded(user: atcUser, appIdentifier: strongSelf.serverConfig.appIdentifier)
                            strongSelf.delegate?.signUpManagerDidCompleteSignUp(strongSelf, user: atcUser)
                        }
                    } else {
                        self?.showSignUpError(text: error?.localizedDescription ?? "There was an error. Please try again later")
                    }
                }
            } else {
                self.showGenericSignUpError()
            }
            return
        }
        self.delegate?.signUpManagerDidCompleteSignUp(self, user: nil)
    }

    fileprivate func isValid(email: String, pass: String, firstName: String) -> Bool {
        if firstName.count < 2 {
            showSignUpError(text: "Name must be longer than 2 characters.")
            return false
        }

        if email.count < 2 {
            showSignUpError(text: "E-mail must not be empty.")
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            showSignUpError(text: "E-mail must have the correct format.")
            return false
        }

        if (pass.count < 6) {
            showSignUpError(text: "Password must be longer than 6 characters.")
            return false
        }
        return true
    }

    fileprivate func showGenericSignUpError() {
        self.showSignUpError(text: "There was an error during the registration process. Please check all the fields and try again.")
    }

    fileprivate func showSignUpError(text: String) {
        let alert = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.signUpScreen.display(alertController: alert)
    }
}
