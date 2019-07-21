import UIKit
class AboutVC: UIViewController {
    @IBOutlet weak var aboutText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadgeOhSBestplan("plan")
    }
    @IBAction func closeAboutVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
