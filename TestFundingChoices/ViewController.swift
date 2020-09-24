//
//  ViewController.swift
//  TestFundingChoices
//
//  Created by ryokosuge on 2020/09/24.
//

import UIKit
import UserMessagingPlatform

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

// MARK: - IBAction
extension ViewController {

    @IBAction private func touchUpRequest(button: UIButton) {
        requestConsent()
    }

    @IBAction private func touchUpReset(button: UIButton) {
        UMPConsentInformation.sharedInstance.reset()
    }

}

// MARK: - Private

extension ViewController {

    private func requestConsent() {
        print(#function)
        let params = UMPRequestParameters()

        // request
        UMPConsentInformation.sharedInstance.requestConsentInfoUpdate(with: params) {[weak self] (error) in
            print("requestConsentInfoUpdate completionHandler")
            if let error = error {
                print(error)
                return
            }

            let formStatus = UMPConsentInformation.sharedInstance.formStatus
            print("formStatus:  \(formStatus.rawValue)")
            if formStatus == .available {
                self?.loadForm()
            }
        }
    }

    private func loadForm() {
        print(#function)
        UMPConsentForm.load { (form, error) in
            print("UMPConsentForm.load completionHandler")
            if let error = error {
                print(error)
                return
            }
            
            form?.present(from: self) { (dismissError) in
                print("UMPConsentForm.present completionHandler")
                if let error = dismissError {
                    print(error)
                }
            }
        }
    }

}
