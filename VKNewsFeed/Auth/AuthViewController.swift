//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 15.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared().authService
    }
    
    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
