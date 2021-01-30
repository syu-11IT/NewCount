//
//  MemoViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2021/01/30.
//  Copyright © 2021 Saito Syugen. All rights reserved.
//

import UIKit
class MemoViewController:UIViewController,UITextFieldDelegate{
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextview: UITextView!
    var saveData: UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func saveMemo(){
        saveData.set(titleTextField.text, forKey: "title")
        saveData.set(contentTextview.text,forKey: "body")
        titleTextField.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
