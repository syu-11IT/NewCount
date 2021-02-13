//
//  MemoViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2021/01/30.
//  Copyright © 2021 Saito Syugen. All rights reserved.
//

import UIKit
class MemoViewController:UIViewController,UITextFieldDelegate{
  
    var saveData: UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func saveMemo(){
    //    saveData.set(.text, forKey: "title")
    //  saveData.set(.text,forKey: "body")
    //.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
