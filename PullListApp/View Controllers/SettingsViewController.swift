//
//  SettingsViewController.swift
//  PullListApp
//
//  Created by Adam Bazzi on 2019-11-24.
//  Copyright © 2019 Adam Bazzi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchToggle(_ sender: UISwitch) {
        UIApplication.shared.windows.forEach { window in window.overrideUserInterfaceStyle = .dark}
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
