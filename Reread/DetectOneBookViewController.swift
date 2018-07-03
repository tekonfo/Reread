

import UIKit

class DetectOneBookViewController: UIViewController , UIScrollViewDelegate{
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    let scrollView = UIScrollView()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let main = UIScreen.main.bounds
        self.view.addSubview(addScrollView(main))
        scrollView.addSubview(addButton(main))
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
        scrollView.delegate = self
        return scrollView
    }
    
    @objc func addScrollSubView(){
        let main = UIScreen.main.bounds
        let color = [UIColor.black,UIColor.black,UIColor.red,UIColor.green,UIColor.white]
        scrollView.contentSize = CGSize(width: main.width * CGFloat(count), height: (main.height)/2)
        let rect = CGRect(x: 10 + main.width * CGFloat(count-1), y: 100, width: main.width - 10 , height: main.height/2 - 100 )
        let myView = UIView(frame: rect)
        myView.backgroundColor = color[count]
        scrollView.addSubview(myView)
        count += 1
        print(count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let message = appDelegate.message
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))
        self.title = message
    }
    
    func addButton(_ main: CGRect) -> UIButton {
        let image3:UIImage = UIImage(named:"plus.png")!
        let button = UIButton()
        button.frame = CGRect(x:main.width - 100, y: 40 ,width:50, height:50)
        //button.setTitle("Tap me!", for:UIControlState.normal)
        button.setImage(image3, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 36)
        button.backgroundColor = UIColor.init(
            red:0.9, green: 0.9, blue: 0.9, alpha: 1)
        button.addTarget(self,action: #selector(self.addScrollSubView),for: .touchUpInside)
        return button
    }

    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }


}
