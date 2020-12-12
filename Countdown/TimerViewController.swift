//
//  TimerViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2020/07/29.
//  Copyright © 2020 Saito Syugen. All rights reserved.
//

import UIKit
class TimerViewController: UIViewController , UIPickerViewDelegate, {
    var backgroundTaskID : UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
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
            }else if count == getTime ?? 0{
                return
         
            }
            
                   print("buttonCalendarTouchUpInside")
                   
                   
            // ローカル通知の内容
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "Countdown"
            content.subtitle = "タイマー"
            content.body = "設定したタイマーが終了しました"
            content.sound = UNNotificationSound(named:UNNotificationSoundName(rawValue: "gageup2.wav"))

            // タイマーの時間（秒）をセット
            let timer = TimeInterval(getTime! - count)
            // ローカル通知リクエストを作成
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timer), repeats: false)
            let identifier = NSUUID().uuidString
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            // ローカル通知リクエストを登録
            UNUserNotificationCenter.current().add(request){ (error : Error?) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }

                 runTimer()
        }

        @IBAction func StopButton(_ sender: Any) {
            // ローカル通知の全削除
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        timer.invalidate()
        
        
        }


        @IBAction func ResetButton(_ sender: Any) {
            // ローカル通知の全削除
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                timer.invalidate()
            count = 0
            timerLabel.text = timeString(time: TimeInterval(getTime ?? 0))

        }

        @IBAction func backButton(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }

        // カウントダウンをする関数
        @objc func updateTimer() -> Int {

            count += 1
            print(count)
            //時間　＝　pickerで設定する時間　ー　count
            let remainCount = getTime! - count
            timerLabel.text = timeString(time: TimeInterval(remainCount))
            //0秒になったら止まる
                   if remainCount == 0 {
                       timer.invalidate()
                       timerLabel.text = "00:00:00"
                       let alert: UIAlertController = UIAlertController(title: "時間終了！",message: "お疲れ様でした",preferredStyle: .alert)
                       alert.addAction(
                       UIAlertAction(
                        title: "OK",style: .default,handler: {(action: UIAlertAction!) in //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                             // 0.5秒後に実行したい処理
                                let storyboard: UIStoryboard = self.storyboard!
                                let nextView = storyboard.instantiateViewController(withIdentifier: "Evaluation")
                                self.present(nextView, animated: true, completion: nil)
                             }}))
                       alert.addAction(
                        UIAlertAction(
                            title:"NO",style: .cancel,handler: {action in print("Cancel")}))
                       present(alert, animated: true, completion: nil)
                   }
                   

    //            timerLabel.text = "\(remainCount)"
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
                
               
        }
   
            
        

        override func viewDidAppear(_ animated: Bool) {

            timerLabel.text = timeString(time: TimeInterval(getTime ?? 0))
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

