//
//  TimerViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2020/07/29.
//  Copyright © 2020 Saito Syugen. All rights reserved.
//

import UIKit
class TimerViewController: UIViewController {

        var timer = Timer()
        var count = 0
        var getTime:Int!
    var label2:String!

    
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

        }

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
