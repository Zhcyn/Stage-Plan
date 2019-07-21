import UIKit
class SendFormVC: UIViewController, UITextFieldDelegate {
    var screenName: String?
    @IBOutlet weak var screenTitle: UINavigationItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var msgTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenTitle.title = screenName
    }
    @IBAction func cancelBarBtnTap(_ sender: UIBarButtonItem) {
        hideKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendBarBtnTap(_ sender: UIBarButtonItem) {
        hideKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    func hideKeyboard(){
        if (titleTextField.isFirstResponder){
            titleTextField.resignFirstResponder()
        }
        if(msgTextField.isFirstResponder){
            msgTextField.resignFirstResponder()
        }
    }
}
