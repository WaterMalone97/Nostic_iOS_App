//
//  DeveloperSettingsViewController.swift
//  SpotifyAPITest
//
//  Created by Ryan Malone on 2/15/20.
//  Copyright © 2020 Ryan Malone. All rights reserved.
//

import UIKit
var address = "https://nostic.herokuapp.com" //initialize to hosted server
var hostedAddress = "https://nostic.herokuapp.com"

class DeveloperSettingsViewController: UIViewController, UITextFieldDelegate {
    var homeViewController: HomeViewController?
    @IBOutlet weak var useLocalIPToggle: UISwitch!
    @IBOutlet weak var useHttpsToggle: UISwitch!
    @IBAction func useLocalIP(_ sender: Any) {
        defaults?.set(useLocalIPToggle.isOn, forKey: defaultsKeys.useLocalIp)
        self.viewDidLoad()
    }
    @IBAction func useHttps(_ sender: Any) {
        defaults?.set(useHttpsToggle.isOn, forKey: defaultsKeys.useHttps)
        self.viewDidLoad()
    }
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var localIPTextField: UITextField!
    var defaults: UserDefaults?

    override func viewDidLoad() {
        if let useLocalIp = defaults?.bool(forKey: defaultsKeys.useLocalIp) {
            useLocalIPToggle.isOn = useLocalIp
        }
        else {
            useLocalIPToggle.isOn = false
        }
        if let useHttps = defaults?.bool(forKey: defaultsKeys.useHttps) {
            useHttpsToggle.isOn = useHttps
        }
        else {
            useHttpsToggle.isOn = false
        }
        if let localIp = defaults?.string(forKey: defaultsKeys.localIp) {
            localIPTextField.placeholder = localIp
        }
        else {
            defaults?.set("", forKey: defaultsKeys.localIp)
        }
        if useLocalIPToggle.isOn {
            address = (defaults?.string(forKey: defaultsKeys.localIp))!
            if (useHttpsToggle.isOn) {
                addressLabel.text = "https://\(String(describing: address))"
                address = "https://\(address)"
            }
            else {
                addressLabel.text = "http://\(String(describing: address))"
                address = "http://\(address)"
            }
        }
        else {
            addressLabel.text = hostedAddress
            address = hostedAddress
        }
        defaults?.set(address, forKey: defaultsKeys.address)
        homeViewController?.viewWillAppear(true)
        super.viewDidLoad()
        self.localIPTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Pressed")
        defaults?.set(textField.text, forKey: defaultsKeys.localIp)
        textField.endEditing(true)
        self.viewDidLoad()
        return false
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
