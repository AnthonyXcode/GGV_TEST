//
//  InfoViewController.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 15/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        if let name = nameTF.text {
            defaults.set(name, forKey: Constants.USERNAME)
        }
        if let email = emailTF.text {
            defaults.set(email, forKey: Constants.EMAIL_ADDRESS)
        }
        if let phone = phoneTF.text {
            defaults.set(phone, forKey: Constants.PHONE_NUMBER)
        }
        let alert = UIAlertController(title: "Save Success", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    let helper = Helper()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLayout() {
        let backgroundLayer = helper.getBackgroundLayer()
        backgroundLayer.frame = view.frame
        bgView.layer.insertSublayer(backgroundLayer, at: 0)
        
        if let userName = defaults.string(forKey: Constants.USERNAME) {
            nameTF.text = userName
        }
        if let phoneNumber = defaults.string(forKey: Constants.PHONE_NUMBER) {
            phoneTF.text = phoneNumber
        }
        if let email = defaults.string(forKey: Constants.EMAIL_ADDRESS) {
            emailTF.text = email
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
