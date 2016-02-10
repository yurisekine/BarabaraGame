//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by SEKINE YURI on 2016/02/10.
//  Copyright © 2016年 SEKINE YURI. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingLabel1: UILabel! //1位のスコアを表示するラベル
    @IBOutlet var rankingLabel2: UILabel! //2位
    @IBOutlet var rankingLabel3: UILabel! //3位
    
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults() //スコアの保存をするための変数

    override func viewDidLoad() {
        super.viewDidLoad()

        rankingLabel1.text = String(defaults.integerForKey("score1")) //"score1"というキーの値を取得して表示
        rankingLabel2.text = String(defaults.integerForKey("score2"))
        rankingLabel3.text = String(defaults.integerForKey("score3"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toTop() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
