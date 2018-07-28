import UIKit

class SearchViewController: UIViewController , UISearchBarDelegate{
private var mySearchBar: UISearchBar!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.tapped(_:)))
        self.view.addGestureRecognizer(tapGesture)
        let navigationBarHeight:CGFloat = self.navigationController!.navigationBar.frame.size.height;
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.frame = CGRect(x: 0,y: navigationBarHeight,width: self.view.bounds.width,height: 100)
        mySearchBar.showsBookmarkButton = false
        mySearchBar.searchBarStyle = UISearchBarStyle.default
        mySearchBar.showsSearchResultsButton = true
        mySearchBar.placeholder = "名前、著者名"
        mySearchBar.showsSearchResultsButton = false
        self.view.addSubview(mySearchBar)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if(mySearchBar.isFirstResponder){
            mySearchBar.resignFirstResponder()
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        let session = URLSessionGetClient()
        let query:String = session.add_query(query_data: searchBar.text!)
        self.performSegue(withIdentifier: "ToSearchResult", sender: query)
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
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearchResult" {
            let resultsearchtableViewController = segue.destination as!   ResultSearchTableViewController
            resultsearchtableViewController.query = sender as! String
        }
    }

}
