//
//  ATCClassicLoginScreenViewController.swift
//  DashboardApp
//
//  Created by Florian Marcu on 8/9/18.
//  Copyright © 2018 Instamobile. All rights reserved.
//

import AuthenticationServices
import UIKit

class ATCClassicLoginScreenViewController: UIViewController, ATCLoginScreenProtocol {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var passwordTextField: FlipBitTextField!
    @IBOutlet var contactPointTextField: FlipBitTextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var separatorLabel: UILabel!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var appleSignInStackView: UIStackView!

    weak var delegate: ATCLoginScreenDelegate?
    let uiConfig: ATCOnboardingConfigurationProtocol

    init(uiConfig: ATCOnboardingConfigurationProtocol) {
        self.uiConfig = uiConfig
        super.init(nibName: "ATCClassicLoginScreenViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.loginScreenDidLoadView(self)
        backButton.tintColor = UIColor(hexString: "#282E4F")
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
        self.view.backgroundColor = uiConfig.backgroundColor

        setupProviderLoginView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }

    private func setupProviderLoginView() {
        if #available(iOS 13.0, *) {
            let style: ASAuthorizationAppleIDButton.Style = (ATCHostViewController.darkModeEnabled() ? .white : .black)
            let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn,
                                                                   authorizationButtonStyle: style)
            authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
            self.appleSignInStackView.addArrangedSubview(authorizationButton)
        } else {
            // Fallback on earlier versions
            print("Apple Signin button not supported on this device.")
        }
    }

    @available(iOS 13.0, *)
    @objc private func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

@available(iOS 13.0, *)
extension ATCClassicLoginScreenViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            self.delegate?.loginScreen(self,
                                       didFetchAppleUserWith: fullName?.givenName,
                                       lastName: fullName?.familyName,
                                       email: email,
                                       password: userIdentifier)
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            self.delegate?.loginScreen(self,
                                       didFetchAppleUserWith: nil,
                                       lastName: nil,
                                       email: username,
                                       password: password)
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension ATCClassicLoginScreenViewController: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

