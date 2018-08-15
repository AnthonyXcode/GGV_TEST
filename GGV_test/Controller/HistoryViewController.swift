//
//  HistoryViewController.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 15/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var bgView: UIView!
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet var tableView: UITableView!
    
    let helper = Helper()
    let realm = try! Realm()
    var allRecord: Results<RecodDoc>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (allRecord?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        cell.backgroundColor = UIColor.clear
        let index = indexPath[1]
        let record = allRecord![index]
        cell.taskName.text = record.name
        helper.setupTimeLab(countSecond: record.timeSpent, lable: cell.timeSpent)
        helper.setupTimeLab(countSecond: record.maxTime, lable: cell.maxTime)
        return cell
    }
    
    func setupLayout() {
        allRecord = realm.objects(RecodDoc.self)
        let backgroundLayer = helper.getBackgroundLayer()
        backgroundLayer.frame = view.frame
        bgView.layer.insertSublayer(backgroundLayer, at: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
