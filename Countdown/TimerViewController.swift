//
//  TimerViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2020/07/29.
//  Copyright © 2020 Saito Syugen. All rights reserved.
//

import UIKit
class TimerViewController: UIViewController , UIPickerViewDelegate{
    
    let dateFormatter = DateFormatter()
        var timer = Timer()
        var count = 0
        var getTime:Int!
    var label2:String!

    @IBOutlet weak var timePicker: UIPickerView!
        @IBOutlet weak var timerLabel: UILabel!

        @IBAction func StartButton(_ sender: Any) {
         //タイマーが有効なら　何もしない
         if timer.isValid == true {
                    return
            }else if count == getTime!{
                return
         
            }

                 runTimer()
        }

        @IBAction func StopButton(_ sender: Any) {

        timer.invalidate()
        }


        @IBAction func ResetButton(_ sender: Any) {

                timer.invalidate()
            count = 0
            timerLabel.text = timeString(time: TimeInterval(getTime))

        }

        @IBAction func backButton(_ sender: Any) {

            let storyboard: UIStoryboard = self.storyboard!
            let picikerboard = storyboard.instantiateViewController(withIdentifier: "pickerboard") as! ViewController

            self.present(picikerboard, animated: true, completion: nil)
        }

        // カウントダウンをする関数
        @objc func updateTimer() -> Int {

            count += 1
            //時間　＝　pickerで設定する時間　ー　count
            let remainCount = getTime! - count
            timerLabel.text = timeString(time: TimeInterval(remainCount))

    //            timerLabel.text = "\(remainCount)"

    //        0秒になったら止まる
            if remainCount == 0 {
                timer.invalidate()
                timerLabel.text = "00:00:00"
                let alert: UIAlertController = UIAlertController(title: "時間終了！",message: "お疲れ様でした",preferredStyle: .alert)
                alert.addAction(
                UIAlertAction(
                    title: "OK",style: .default,handler: {action in print("e")}))
                present(alert, animated: true, completion: nil)
            }
                return remainCount

        }

        //タイマーを動かす関数
        func runTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        }

        //00:00:00に変える処理
          func timeString(time: TimeInterval) -> String {
              let hour = Int(time) / 3600
              let minutes = Int(time) / 60 % 60
              let second = Int(time) % 60

              return String(format: "%02d:%02d:%02d", hour, minutes, second)
          }

        override func viewDidLoad() {
            super.viewDidLoad()
                // 日付フォーマット
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.timeStyle = .short
                dateFormatter.dateStyle = .short
                dateFormatter.locale = Locale(identifier: "ja_JP")
                // 日時指定通知のボタン作成
                       let buttonCalendar = UIButton()
                       buttonCalendar.frame = CGRect(x:10, y:40, width:200, height:50)
                       buttonCalendar.setTitle("日時指定通知", for:UIControl.State.normal)
                       buttonCalendar.backgroundColor = UIColor.red
                       buttonCalendar.addTarget(self,
                                                action: #selector(TimerViewController.buttonCalendarTouchUpInside(sender:)),
                                                for: .touchUpInside)
                       self.view.addSubview(buttonCalendar)
                // タイマー通知のボタン作成
                        let buttonTimer = UIButton()
                        buttonTimer.frame = CGRect(x:10, y:100, width:200, height:50)
                        buttonTimer.setTitle("タイマー通知", for:UIControl.State.normal)
                        buttonTimer.backgroundColor = UIColor.blue
                        buttonTimer.addTarget(self,
                                              action: #selector(TimerViewController.buttonTimerTouchUpInside(sender:)),
                                              for: .touchUpInside)
                        self.view.addSubview(buttonTimer)
                // 実行待ち通知一覧
                       let buttonPendingList = UIButton()
                       buttonPendingList.frame = CGRect(x:10, y:160, width:200, height:50)
                       buttonPendingList.setTitle("実行待ち通知一覧", for:UIControl.State.normal)
                       buttonPendingList.backgroundColor = UIColor.orange
                       buttonPendingList.addTarget(self,
                                                   action: #selector(TimerViewController.buttonPendingListTouchUpInside(sender:)),
                                                   for: .touchUpInside)
                       self.view.addSubview(buttonPendingList)
                // 実行済み通知一覧
                        let buttonDeliveredList = UIButton()
                        buttonDeliveredList.frame = CGRect(x:10, y:220, width:200, height:50)
                        buttonDeliveredList.setTitle("実行済み通知一覧", for:UIControl.State.normal)
                        buttonDeliveredList.backgroundColor = UIColor.purple
                        buttonDeliveredList.addTarget(self,
                                                      action: #selector(TimerViewController.buttonDeliveredListTouchUpInside(sender:)),
                                                      for: .touchUpInside)
                        self.view.addSubview(buttonDeliveredList)
            }
            @objc func buttonCalendarTouchUpInside(sender : UIButton) {
                   print("buttonCalendarTouchUpInside")
                   // ローカル通知のの内容
                   let content = UNMutableNotificationContent()
                   content.sound = UNNotificationSound.default
                   content.title = "ローカル通知テスト"
                   content.subtitle = "日時指定"
                   content.body = "日時指定によるタイマー通知です"
                   
                   // ローカル通知実行日時をセット（5分後)
                   let date = Date()
                   let newDate = Date(timeInterval: TimeInterval(getTime), since: date)
                let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: newDate)// ローカル通知リクエストを作成
                let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
                // ユニークなIDを作る
                let identifier = NSUUID().uuidString
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                // ローカル通知リクエストを登録
                UNUserNotificationCenter.current().add(request){ (error : Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }}
            @objc func buttonTimerTouchUpInside(sender : UIButton) {
                    print("buttonTimerTouchUpInside")
                    
                    // ローカル通知の内容
                    let content = UNMutableNotificationContent()
                    content.sound = UNNotificationSound.default
                    content.title = "ローカル通知テスト"
                    content.subtitle = "タイマー通知"
                    content.body = "タイマーによるローカル通知です"

                    // タイマーの時間（秒）をセット
                    let timer = TimeInterval(getTime)
                    // ローカル通知リクエストを作成
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timer), repeats: false)
                    let identifier = NSUUID().uuidString
                    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request){ (error : Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
            @objc func buttonPendingListTouchUpInside(sender : UIButton) {
                    print("<Pending request identifiers>")

                    let center = UNUserNotificationCenter.current()
                    center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                        for request in requests {
                            print("identifier:\(request.identifier)")
                            print("  title:\(request.content.title)")

                            if request.trigger is UNCalendarNotificationTrigger {
                                let trigger = request.trigger as! UNCalendarNotificationTrigger
                                print("  <CalendarNotification>")
                                let components = DateComponents(calendar: Calendar.current, year: trigger.dateComponents.year, month: trigger.dateComponents.month, day: trigger.dateComponents.day, hour: trigger.dateComponents.hour, minute: trigger.dateComponents.minute)
                                print("    Scheduled Date:\(self.dateFormatter.string(from: components.date!))")
                                print("    Reperts:\(trigger.repeats)")
                                
                            } else if request.trigger is UNTimeIntervalNotificationTrigger {
                                let trigger = request.trigger as! UNTimeIntervalNotificationTrigger
                                print("  <TimeIntervalNotification>")
                                print("    TimeInterval:\(trigger.timeInterval)")
                                print("    Reperts:\(trigger.repeats)")
                            }
                            print("----------------")}}}
            @objc func buttonDeliveredListTouchUpInside(sender : UIButton) {
                    print("<Delivered request identifiers>")

                    let center = UNUserNotificationCenter.current()
                    center.getDeliveredNotifications { (notifications: [UNNotification]) in
                        for notification in notifications {
                            print("identifier:\(notification.request.identifier)")
                            print("  title:\(notification.request.content.title)")

                            if notification.request.trigger is UNCalendarNotificationTrigger {
                                let trigger = notification.request.trigger as! UNCalendarNotificationTrigger
                                print("  <CalendarNotification>")
                                let components = DateComponents(calendar: Calendar.current, year: trigger.dateComponents.year, month: trigger.dateComponents.month, day: trigger.dateComponents.day, hour: trigger.dateComponents.hour, minute: trigger.dateComponents.minute)
                                print("    Scheduled Date:\(self.dateFormatter.string(from: components.date!))")
                                print("    Reperts:\(trigger.repeats)")
                                
                            } else if notification.request.trigger is UNTimeIntervalNotificationTrigger {
                                let trigger = notification.request.trigger as! UNTimeIntervalNotificationTrigger
                                print("  <TimeIntervalNotification>")
                                print("    TimeInterval:\(trigger.timeInterval)")
                                print("    Reperts:\(trigger.repeats)")
                            }
                            print("----------------")
                        }}}
            

        override func viewDidAppear(_ animated: Bool) {

            timerLabel.text = timeString(time: TimeInterval(getTime))
            print(getTime ?? "this is nil")

        }
    
// Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
