import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        
        let initialUrl = URL(string: "https://www.carpages.ca/used-cars/search/?search_radius=100&province_code=on&city=toronto&sort=price_desc&ll=43.6656,-79.383")
        
        webView.loadRequest(URLRequest(url: initialUrl!))
        
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func configureView() {
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = "Loading"
                
                if let url = URL(string: detail["url"].stringValue) {
                    let request = URLRequest(url: url)
                    webView.loadRequest(request)
                }
            }
        }
    }
    
    var detailItem: JSON? {
        didSet {
            self.configureView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

