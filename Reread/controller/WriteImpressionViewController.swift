import UIKit
import RealmSwift

class WriteImpressionViewController: UIViewController, UITextViewDelegate {
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    var name:String = ""
    
    @IBOutlet weak var memo: UITextView!
    @IBAction func cancel(_ sender: UIButton) {
        memo.resignFirstResponder()
    }
    
    
    @IBAction func sendImpression(_ sender: UIButton) {
        let realm = try! Realm()
        let add_memo = Memos()
        let impression = realm.objects(Impressions.self).filter("title =  '\(appDelegate.message)'")[0]
        add_memo.memo = memo.text
        add_memo.date = Date()
        try! realm.write() {
            impression.memos.append(add_memo)
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
