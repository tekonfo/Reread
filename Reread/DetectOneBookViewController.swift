//
//  DetectOneBookViewController.swift
//  Reread
//
//  Created by 近藤大翔 on 2018/06/27.
//  Copyright © 2018年 近藤大翔. All rights reserved.
//

import UIKit

class DetectOneBookViewController: UIViewController , UIScrollViewDelegate{
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    let scrollView = UIScrollView()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.backgroundColor = UIColor.gray
        let main = UIScreen.main.bounds
        // 表示窓のサイズと位置を設定
        scrollView.frame.size = CGSize(width: main.width, height: main.height/2)
        scrollView.center = self.view.center

        // 中身の大きさを設定
        scrollView.contentSize = CGSize(width: main.width * 3, height: (main.height)/2)

        // スクロールバーの見た目と余白
        scrollView.indicatorStyle = .white
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // Delegate を設定
        scrollView.delegate = self

        self.view.addSubview(scrollView)
        
        addScrollSubView(k: 1)
        addScrollSubView(k: 2)
        scrollView.addSubview(addButton(main))
//        scrollView.contentSize.width = main.width*2
//        scrollView.delegate = self
//        let rect2 = CGRect(x: main.width +  10, y: 20, width: main.width*2 - 20 , height: main.height/2 - 30 )
//        let myView2 = UIView(frame: rect2)
//        myView.backgroundColor = .white
//        scrollView.addSubview(myView2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addView(_ main: CGRect) -> UIView{
        let rect = CGRect(x: 10, y: 20, width: main.width - 10 , height: main.height/2 - 10 )
        let myView = UIView(frame: rect)
        return myView
    }
    
    @objc func addScrollSubView(k:Int){
        let main = UIScreen.main.bounds
        let color = [UIColor.black,UIColor.black,UIColor.red,UIColor.green,UIColor.white]
        let rect = CGRect(x: 10 + main.width * CGFloat(k-1), y: 20, width: main.width - 10 , height: main.height/2 - 100 )
        let myView = UIView(frame: rect)
        myView.backgroundColor = color[k]
        scrollView.addSubview(myView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let message = appDelegate.message
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))
        self.title = message
    }
    
    
    
    func addButton(_ main: CGRect) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x:main.width - 100, y: 50 ,
                              width:100, height:100)
        button.setTitle("Tap me!", for:UIControlState.normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 36)
        button.backgroundColor = UIColor.init(
            red:0.9, green: 0.9, blue: 0.9, alpha: 1)
        button.addTarget(self,
                         action: #selector(DetectOneBookViewController.addScrollSubView(k:count)),
                         for: .touchUpInside)
        count = count + 1
        return button
    }

    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
