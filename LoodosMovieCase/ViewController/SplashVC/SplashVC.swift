//
//  SplashVC.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 14.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            getValuesFromFRC()
        }else {
            self.showTryAgainAlert(title: "Hata", message: "Lütfen internet bağlantınızı kontrol ediniz.", isCancelable: false) { (_) in
                self.viewDidLoad()
            }
        }
        // Do any additional setup after loading the view.
    }
    func getValuesFromFRC(){
        if RCValues.shared.fetchComplete {
            updateButton()
        }
        RCValues.shared.loadingDoneCallback = updateButton
    }

    // MARK: UI Update
    func updateButton() {
        startButton.isEnabled = true
        DispatchQueue.main.async {
            self.startButton.setTitle(RCValues.shared.string(forKey: .welcomeMessage), for: .normal)
        }
    }

    

}

//MARK: Button Actions
extension SplashVC {
    @IBAction func startButtonAction(_ sender: Any) {
    }
}
