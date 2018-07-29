//
//  TopTableViewController.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/06/25.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import UIKit
import RealmSwift

class TopTableViewController: UITableViewController {
    let image1 = UIImage(named: "setting.jpeg")
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let settingImage = UIImage(named: "icon_000010_256.jpg")
        let leftButton1 =  UIBarButtonItem( barButtonSystemItem: UIBarButtonSystemItem(rawValue: 12)!, target: self, action:  #selector(TopTableViewController.newTodo))
        let leftButton2 = UIBarButtonItem(title: "ranking", style: UIBarButtonItemStyle.plain, target: self, action:  #selector(TopTableViewController.ranking))
        
        
        self.navigationItem.rightBarButtonItems = [leftButton1,leftButton2]
        
        
        let rightButton1 =  UIBarButtonItem(title: "setting", style: UIBarButtonItemStyle.plain, target: self, action:  #selector(TopTableViewController.newTodo))
        let rightButton2 = UIBarButtonItem(title: "bookpool", style: UIBarButtonItemStyle.plain, target: self, action:  #selector(TopTableViewController.newTodo))
        
        self.navigationItem.leftBarButtonItems = [rightButton1,rightButton2]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let arrays = realm.objects(Impressions.self)
        
        if(arrays.count == 0){
            return 0
        }else{
            return arrays.count // "違う値だよ"
        }
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "削除してもいいですか？", preferredStyle:  UIAlertControllerStyle.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                let realm = try! Realm()
                let arrays = realm.objects(Impressions.self)
                let data = arrays[indexPath.row]
                do {
                    let realm = try Realm()
                    try! realm.write {
                        realm.delete(data)
                    }
                } catch {
                }
                //下のやつは、先にデータを削除してからでないとクラッシュする。なぜだろう。
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            let canselAction: UIAlertAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                })
            alert.addAction(canselAction)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let realm = try! Realm()
        let arrays = realm.objects(Impressions.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = arrays[indexPath.row].title
        cell.detailTextLabel?.text = arrays[indexPath.row].creator
        let beautifulImage = UIImage(named: "1p3i86c-kai.jpg")
        cell.imageView?.image = beautifulImage
        return cell
    }
    
    @objc func ranking(){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "ranking") as! UITabBarController
        self.present(nextView, animated: true, completion: nil)
    }
    
    @objc func newTodo(){
        self.performSegue(withIdentifier: "ToSearchViewController", sender: self)
        
    }
    
    @objc func setting(){
        
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at:indexPath)
        appDelegate.message = cell?.textLabel!.text! as! String
        //ここに遷移処理を書く
        self.performSegue(withIdentifier: "ToDetectViewController", sender: self)
    }
}
