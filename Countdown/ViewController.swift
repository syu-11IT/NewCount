//
//  ViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2020/07/29.
//  Copyright © 2020 Saito Syugen. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,backgroundTimerDelegate {
    var timer2:Timer!
    let timeList = [[Int](0...23), [Int](0...59), [Int](0...59)]
    let dateFormatter = DateFormatter()
    var pickerdata:String!
    var timeTotal:Int!
    var currentTime = 15
    @IBOutlet weak var currentTimeLabel: UILabel!
    //タイマー起動中にバックグラウンドに移行したか
    var timerIsBackground = false

    @IBOutlet weak var timePicker: UIPickerView!
    @IBAction func doneButton(_ sender: Any) {
        total()
        if timeTotal == 0{return}else if timeTotal > 0 {
        let storyboard: UIStoryboard = self.storyboard!
        let timer = storyboard.instantiateViewController(withIdentifier: "timer") as! TimerViewController

        timer.getTime = timeTotal

        self.present(timer, animated: true, completion: nil)
        }}
    override func viewDidLoad() {
        super.viewDidLoad()
        // 日付フォーマット
        timePicker.dataSource = self
        timePicker.delegate = self
        //SceneDelegateを取得
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
                    return
        }
                sceneDelegate.delegate = self
    
}
    @objc func advancedTime() {
           //残り時間が1秒以上あるか
           if currentTime >= 1 {
               currentTime -= 1
               currentTimeLabel.text = "\(currentTime)"
           } else {
               timer2.invalidate()
               
               currentTime = 15
               currentTimeLabel.text = "\(currentTime)"
           }
       }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeList.count
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeList[component].count
       }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(timeList[component][row])

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        total()
        }

//    pickerの数字をたすメソッド
    func total() {
        timeTotal = timeList[0][timePicker.selectedRow(inComponent: 0)] * 60 * 60 + timeList[1][timePicker.selectedRow(inComponent: 1)] * 60 + timeList[2][timePicker.selectedRow(inComponent: 2)]

    }
    func checkBackground() {
        //バックグラウンドへの移行を確認
        if let _ = timer2 {
            timerIsBackground = true
        }
    }
        func setCurrentTimer(_ elapsedTime:Int) {
            //残り時間から引数(バックグラウンドでの経過時間)を引く
            currentTime -= elapsedTime
            currentTimeLabel.text = "\(currentTime)"
            //再びタイマーを起動
            timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(advancedTime), userInfo: nil, repeats: true)
        }

        func deleteTimer() {
            //起動中のタイマーを破棄
            if let _ = timer2 {
                timer2.invalidate()
            }
        }
    /// ローカル通知ボタンを押下した際の処理
        /// - Parameter sender: ローカル通知ボタン
        //@IBAction func localPush(_ sender: Any) {
            //let content = UNMutableNotificationContent()
           // content.title = "お知らせ"
            //content.body = "ボタンを押しました。"
            //content.sound = UNNotificationSound.default

            // 直ぐに通知を表示
            //let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
            //UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        //}
    }




