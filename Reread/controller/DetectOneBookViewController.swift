

import UIKit
import RealmSwift

class LabelButton: UIButton {
    //検索時の添え字を入れておきたいので、それを入れておく。
    var index:Int?
    var id = ""
    var memo = ""
}

class DetectOneBookViewController: UIViewController , UIScrollViewDelegate{
   
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    let scrollView = UIScrollView()
    let color = [UIColor.white,UIColor.green,UIColor.red,UIColor.green,UIColor.white]
    var arr_memos:[Memos] = []
    
    override func viewDidLoad() {
        
        //viewdidloadはインスタンスを再作成しているらしい
        super.viewDidLoad()
        let main = UIScreen.main.bounds
        self.view.addSubview(addScrollView(main))
        self.view.addSubview(addButton(main))
        let realm = try! Realm() //Realmのインスタンスを取得
        let impres = realm.objects(Impressions.self).filter("title =  '\(appDelegate.message)'")
        let memos = impres[0].memos
        let memos2 = memos.sorted(byKeyPath: "date")
        for memo in memos2{
            self.arr_memos.append(memo)
        }
        if self.arr_memos.isEmpty {
        }else{
            for (index , element) in memos.enumerated() {
                showScrollSubView(memo: element,index: index)
            }
        }
        let message = appDelegate.message
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))
        self.title = message

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addView(_ main: CGRect) -> UIView{
        let rect = CGRect(x: 10, y: 20, width: main.width - 10 , height: main.height/2 - 10 )
        let myView = UIView(frame: rect)
        return myView
    }
    
    func addScrollView(_ main: CGRect) -> UIScrollView {
        scrollView.backgroundColor = UIColor.gray
        scrollView.frame.size = CGSize(width: main.width, height: main.height/2)
        scrollView.center = self.view.center
        scrollView.contentSize = CGSize(width: main.width, height: (main.height)/2)
        scrollView.indicatorStyle = .white
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }
    
    func make_date(day: Date) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: day)
        let month = calendar.component(.month, from: day)
        let days = calendar.component(.day, from: day)
        return String(year) + "年" + String(month) + "月 " + String(days) + "日"
    }
    
    
    func showScrollSubView(memo: Memos,index: Int){
        let main = UIScreen.main.bounds
        let rect1 =  CGRect(x: 0, y: 100, width: 200 , height: 50 )
        let label = UILabel(frame: rect1)
        label.text = memo.memo
        let rect2 =  CGRect(x: 0, y: 0, width: 200 , height: 50 )
        let label2 = UILabel(frame: rect2)
        label2.text = make_date(day: memo.date)
        scrollView.contentSize = CGSize(width: main.width * CGFloat(index+1), height: (main.height)/2)
        let rect = CGRect(x: 5 + main.width * CGFloat(index), y: 50, width: main.width - 10 , height: main.height/2 - 100 )
        let myView = UIView(frame: rect)
        let button = make_threePoint_button(index: index,id :memo.id, memo: memo.memo)
        myView.backgroundColor = color[index]
        myView.addSubview(label)
        myView.addSubview(label2)
        myView.addSubview(button)
        scrollView.addSubview(myView)
    }
    
    func make_threePoint_button(index: Int,id: String,memo: String)-> UIButton{
        let main = UIScreen.main.bounds
        let button = LabelButton()
        let image = UIImage(named: "3point.png")
        button.id = id
        button.memo = memo
        button.setImage(image, for: .normal)
        button.backgroundColor = color[index]
        button.addTarget(self, action: #selector(DetectOneBookViewController.onClickMyButton(_:)), for: .touchUpInside)
        let rect = CGRect(x: main.width - 50, y: 10, width: 30 , height: 30 )
        button.frame = rect
        return button
    }
    
    @objc func onClickMyButton(_ sender:LabelButton){
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "保存してもいいですか？", preferredStyle:  UIAlertControllerStyle.actionSheet)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // 編集
        let editAction: UIAlertAction = UIAlertAction(title: "編集", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "ToWriteImpressionViewController", sender:sender)
        })
        //削除
        let deleteAction: UIAlertAction = UIAlertAction(title: "削除", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            let realm = try! Realm()
            let memo = realm.objects(Memos.self).filter("id = '\(sender.id)'")
            do {
                try! realm.write {
                    realm.delete(memo)
                }
            }
            self.arr_memos.removeAll()
            self.viewDidLoad()
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    func edit_memo(index: Int){
    }
    
    func delete_memo(index: Int){
    }
    
    
    @objc func addScrollSubView(){
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm() //Realmのインスタンスを取得
        let impres = realm.objects(Impressions.self).filter("title =  '\(appDelegate.message)'")
        let memos = impres[0].memos
        let memos2 = memos.sorted(byKeyPath: "date")
        for memo in memos2{
            self.arr_memos.append(memo)
        }
        if self.arr_memos.isEmpty {
        }else{
            for (index , element) in memos.enumerated() {
                showScrollSubView(memo: element,index: index)
            }
        }
    }
    
    func addButton(_ main: CGRect) -> UIButton {
        let image3:UIImage = UIImage(named: "plus.png")!
        let button = UIButton()
        button.frame = CGRect(x:main.width / 2 - 50 , y: main.height - 150 ,width:100, height:100)
        button.setImage(image3, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,action: #selector(self.onClickAddButton),for: .touchUpInside)
        return button
    }
    
    @objc func onClickAddButton(){
        performSegue(withIdentifier: "ToWriteImpressionViewController", sender: self)
    }
    
    
    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToWriteImpressionViewController" {
            if sender is LabelButton {
                let button = sender as! LabelButton
                let nc = segue.destination as! UINavigationController
                let writeimpressionviewcontroller = nc.topViewController as! WriteImpressionViewController
                writeimpressionviewcontroller.e_memo = button.memo
                writeimpressionviewcontroller.id = button.id
            }
        }
    }

}
