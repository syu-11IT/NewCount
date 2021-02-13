//
//  CellViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2021/02/13.
//  Copyright © 2021 Saito Syugen. All rights reserved.
//

import UIKit
class CellViewcontroller:UIViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var table: UITableView!
    var hoge = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
    }
    override func didReceiveMemoryWarning() {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "test"
        return cell!
    }
    
    
}
