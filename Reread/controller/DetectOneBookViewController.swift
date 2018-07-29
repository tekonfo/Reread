

import UIKit
import RealmSwift

class DetectOneBookViewController: UIViewController , UIScrollViewDelegate{
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let main = UIScreen.main.bounds
        self.view.addSubview(addScrollView(main))
        self.view.addSubview(addButton(main))
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
        let color = [UIColor.white,UIColor.green,UIColor.red,UIColor.green,UIColor.white]
        scrollView.contentSize = CGSize(width: main.width * CGFloat(index+1), height: (main.height)/2)
        let rect = CGRect(x: 5 + main.width * CGFloat(index), y: 50, width: main.width - 10 , height: main.height/2 - 100 )
        let myView = UIView(frame: rect)
        myView.backgroundColor = color[index]
        myView.addSubview(label)
        myView.addSubview(label2)
        scrollView.addSubview(myView)
    }
    
    @objc func addScrollSubView(){
        self.performSegue(withIdentifier: "ToWriteImpressionViewController", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let realm = try! Realm() //Realmのインスタンスを取得
        //let impres = realm.objects(Impressions.self)
        let impres = realm.objects(Impressions.self).filter("title =  '\(appDelegate.message)'")
        let memos = impres[0].memos
        let sorted_memos = memos.sorted(byKeyPath: "date")
        if sorted_memos.isEmpty {
        }else{
            for (index , element) in memos.enumerated() {
                showScrollSubView(memo: element,index: index)
            }
        }
        let message = appDelegate.message
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))
        self.title = message
    }
    
    func addButton(_ main: CGRect) -> UIButton {
        let image3:UIImage = UIImage(named: "plus.png")!
        let button = UIButton()
        button.frame = CGRect(x:main.width / 2 - 50 , y: main.height - 150 ,width:100, height:100)
        button.setImage(image3, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self,action: #selector(self.addScrollSubView),for: .touchUpInside)
        return button
    }

    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }


}
