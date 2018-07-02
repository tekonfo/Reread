//
//  TopTableViewController.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/06/25.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import UIKit

class TopTableViewController: UITableViewController {
 
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let settingImage = UIImage(named: "icon_000010_256.jpg")
        
        let leftButton1 =  UIBarButtonItem(title: "検索", style: UIBarButtonItemStyle.plain, target: self, action:  #selector(TopTableViewController.newTodo))
        let leftButton2 = UIBarButtonItem(title: "ranking", style: UIBarButtonItemStyle.plain, target: self, action:  #selector(TopTableViewController.newTodo))
        
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
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "text"
        cell.detailTextLabel?.text = "aaa"
        let beautifulImage = UIImage(named: "1p3i86c-kai.jpg")
        cell.imageView?.image = beautifulImage

        return cell
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
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//
//        if segue.identifier == "SecondView" {
//            
//            let secondViewController:DetectOneBookViewController = segue.destinationViewController as DetectOneBookViewController
//
//            // 変数:遷移先ViewController型 = segue.destinationViewController as 遷移先ViewController型
//            // segue.destinationViewController は遷移先のViewController
//
//            secondViewController.sendText= self.textField.text
//        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
