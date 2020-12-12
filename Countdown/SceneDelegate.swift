//
//  SceneDelegate.swift
//  Countdown
//
//  Created by 齋藤就元 on 2020/07/29.
//  Copyright © 2020 Saito Syugen. All rights reserved.
//

import UIKit
//デリゲート用の変数、関数
@objc protocol backgroundTimerDelegate: class {
    func setCurrentTimer(_ elapsedTime:Int)
    func deleteTimer()
    func checkBackground()
    var timerIsBackground:Bool { set get }
}
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    //デリゲート
        weak var delegate: backgroundTimerDelegate?
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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }




