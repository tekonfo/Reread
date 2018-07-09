//
//  WriteImpressionViewController.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/07/04.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import UIKit
import RealmSwift

class WriteImpressionViewController: UIViewController, UITextViewDelegate {
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    @IBOutlet weak var memo: UITextView!
    @IBAction func cancel(_ sender: UIButton) {
        memo.resignFirstResponder()
    }
    
    
    @IBAction func sendImpression(_ sender: UIButton) {
        let realm = try! Realm()
        let impression = Impressions()
        impression.memo = memo.text
        impression.title = appDelegate.message
        impression.date = Date()
        try! realm.write() {
            realm.add(impression)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }
}
