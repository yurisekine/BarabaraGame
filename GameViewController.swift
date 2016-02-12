//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by SEKINE YURI on 2016/02/10.
//  Copyright © 2016年 SEKINE YURI. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imgView1: UIImageView! //上
    @IBOutlet var imgView2: UIImageView! //中
    @IBOutlet var imgView3: UIImageView! //下
    
    @IBOutlet var resultLabel: UILabel! //スコアを表示するラベル
    
    var timer: NSTimer! //画像を動かすためのタイマー
    var score:Int = 1000 //スコアの値
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults() //スコアを保存するための変数
    
    let width:CGFloat = UIScreen.mainScreen().bounds.size.width //画面幅
    var positionX: [CGFloat] = [0.0,0.0,0.0] //画像の位置の配列
    var dx: [CGFloat] = [1.0,0.5,-1.0] //画像の動かす幅の配列
    
    func start() {
        //結果ラベルを見えなくする
        resultLabel.hidden = true
        
        //タイマーを動かす
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005,target: self, selector: "up", userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func up() {
        for i in 0..<3 {
            //端にきたら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i]*(-1)
            }
            positionX[i] += dx[i] //画像の位置をdx分ずらす
        }
        imgView1.center.x = positionX[0] //上の画像をずらした位置に移動させる
        imgView2.center.x = positionX[1] //真ん中の画像をずらした位置に移動させる
        imgView3.center.x = positionX[2] //下の画像
    }
    
    @IBAction func stop() {
        if timer.valid == true { //もしタイマーが動いていたら
            timer.invalidate() //タイマーを止める(無効にする)
            
            for i in 0..<3 {
                score = score - abs(Int(width/2 - positionX[i]))*2 //画像のずれた分だけスコアから値を引く
            }
            resultLabel.text = "Score:" + String(score) //結果ラベルにスコアを表示する
            resultLabel.hidden = false //結果ラベルを隠さない(現す)
        }
        let highScore1: Int = defaults.integerForKey("score1") //ユーザーデフォルトに"score1"というキーの値を取得
        let highScore2: Int = defaults.integerForKey("score2")
        let highScore3: Int = defaults.integerForKey("score3")
        
        if score > highScore1 { //ランキング１位の記録を更新したら
            defaults.setInteger(score, forKey: "score1") //"score1"というキーでscoreを保存
            defaults.setInteger(highScore1, forKey: "score2") //"score2"というキーでhighscore1(元１位の記録)を保存
            defaults.setInteger(highScore2, forKey: "score3") //"score3"というキーでhighscore2(元２位の記録)を保存
            
        } else if score > highScore2 { //ランキング２位の記録を更新したら
            defaults.setInteger(score, forKey: "score2")
            defaults.setInteger(highScore2, forKey: "score3")
            
        } else if score > highScore3 { //ランキング３位の記録を更新したら
            defaults.setInteger(score, forKey: "score3")
            
        }
        defaults.synchronize()
    }
    
    @IBAction func retry() {
        score = 1000 //スコアの値をリセットする
        positionX = [width/2, width/2, width/2] //画像の位置を真ん中に戻す
        self.start() //スタートメソッドを呼び出す
    }
    
    @IBAction func toTop() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        positionX = [width/2, width/2, width/2] //画像の位置を画面幅の中心にする
        self.start() //前ページで書いたstartというメソッドを呼び出す
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
