//
//  MemoViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2021/01/30.
//  Copyright © 2021 Saito Syugen. All rights reserved.
//

import UIKit
class MemoViewController:UIViewController,UITextFieldDelegate{
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!
    var MemoTitle = [String]()
    var MemoArray = [String]()
    var saveData: UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func saveMemo(){
        MemoTitle.append(textField.text!)
        MemoArray.append(textView.text!)
        saveData.set(MemoTitle,forKey: "Title")
        saveData.set(MemoArray,forKey: "Array")
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
