//
//  SceneDelegate.swift
//  Countdown
//
//  Created by 齋藤就元 on 2020/07/29.
//  Copyright © 2020 Saito Syugen. All rights reserved.
//

import UIKit
//デリゲート用の変数、関数
 protocol backgroundTimerDelegate {
    func setCurrentTimer(_ elapsedTime:Int)
    func deleteTimer()
    func checkBackground()
    var timerIsBackground:Bool {  get set }
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    //デリゲート
         var delegate: backgroundTimerDelegate?
        let ud = UserDefaults.standard
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let _ = (scene as? UIWindowScene) else { return }
        }
    //アプリ画面に復帰した時
        func sceneDidBecomeActive(_ scene: UIScene) {
            //タイマー起動中にバックグラウンドへ移行した？
            if delegate?.timerIsBackground == true {
                let calender = Calendar(identifier: .gregorian)
                let date1 = ud.value(forKey: "date1") as! Date
                let date2 = Date()
                let elapsedTime = calender.dateComponents([.second], from: date1, to: date2).second!
                //経過時間（elapsedTime）をbackgroundTimer.swiftに渡す
                delegate?.setCurrentTimer(elapsedTime)
            }
        }
    //アプリ画面から離れる時（ホームボタン押下、スリープ）
        func sceneWillResignActive(_ scene: UIScene) {
            ud.set(Date(), forKey: "date1")
            //タイマー起動中からのバックグラウンドへの移行を検知
            delegate?.checkBackground()
            //タイマーを破棄
            delegate?.deleteTimer()
        }
    }

   



