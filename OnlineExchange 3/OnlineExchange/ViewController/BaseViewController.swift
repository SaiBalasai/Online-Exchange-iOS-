
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionNavigationBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func actionDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
