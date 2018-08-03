//
//  ResultSearchTableViewController.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/07/24.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import UIKit
import RealmSwift

class ResultSearchTableViewController: UITableViewController,XMLParserDelegate {
    var query: String = ""
    var array:[book_data] = []
    var flg_copy_title:Bool = false
    var flg_copy_creator:Bool = false
    var book_title:String = ""
    var book_creator:String = ""
    struct book_data {
        var title: String
        var creator: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let nabigation = UINavigationController(rootViewController: self)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))
        let queryItems = [ URLQueryItem(name:"operation",value: "searchRetrieve"),URLQueryItem(name:"query",value: query),URLQueryItem(name:"maximumRecords",value: "5"),URLQueryItem(name:"recordPacking",value: "xml")]
        //,URLQueryItem(name:"recordSchema",value: "dcndl"),URLQueryItem(name:"onlyBib",value: "true")
        var compnents = URLComponents(string: "http://iss.ndl.go.jp/api/sru")
        compnents?.queryItems = queryItems
        let url = compnents?.url
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data, let _ = response {
                let xmlparse = XMLParser(data: data)
                xmlparse.delegate = self
                xmlparse.parse()
//                非同期通信を行った時、完了ブロック(completionHandler)はメインスレッドでないスレッドで実行されます。
//                iOSのUIなどの描画を行う際には、メインスレッド上で行わないといけないため、完了ブロックの中でUI更新処理を行うと更新されません。
//                そこで、再描画をメインスレッドで実行します。以下のようにすることで、メインスレッドで処理を行うことができます。
                DispatchQueue.main.async {//これ何やってるか全然わからんな
                    self.tableView.reloadData()
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = array[indexPath.row].title
        cell.detailTextLabel?.text = array[indexPath.row].creator
        return cell
    }
    
    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        //cellの情報を保存
        let realm = try! Realm()
        let impressions = Impressions() //Personモデルのオブジェクトを取得
        impressions.title = array[indexPath.row].title
        impressions.creator = array[indexPath.row].creator
        try! realm.write {
            realm.add(impressions)
        }
        
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(withIdentifier: "Top")
        self.present(second, animated: true, completion: nil)
    }

    func parserDidStartDocument(_ parser: XMLParser){
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]){
        if elementName == "dc:creator" {
            flg_copy_creator = true
        }
        if elementName == "dc:title" {
            flg_copy_title = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if flg_copy_title {
            book_title = string
            flg_copy_title = false
        }
        if flg_copy_creator {
            book_creator = string
            flg_copy_creator = false
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "record" {
            //ここにtitieとcreatorを描く処理を入れる
            let book = book_data(title: book_title,creator: book_creator)
            array.append(book)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
    }

}
