import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate{
private var mySearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySearchBar = UISearchBar()
        
        mySearchBar.delegate = self
        
        mySearchBar.frame = CGRect(x: 0,y: 0,width: 300,height: 80)
        
        mySearchBar.layer.position = CGPoint(x: self.view.bounds.width/2, y: 500)
        
        mySearchBar.layer.shadowOpacity = 0.5
        
        mySearchBar.layer.masksToBounds = false
        
        mySearchBar.showsBookmarkButton = false
        
        mySearchBar.searchBarStyle = UISearchBarStyle.default
        
        mySearchBar.prompt = "タイトル"
        
        mySearchBar.placeholder = "ここに入力してください"
        
        mySearchBar.tintColor = UIColor.red
        
        mySearchBar.showsSearchResultsButton = false
        
        self.view.addSubview(mySearchBar)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.close))

    }
    @objc func close()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        print(searchText)
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
