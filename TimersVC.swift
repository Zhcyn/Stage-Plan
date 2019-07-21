import UIKit
class TimersVC: UIViewController {
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var tabSwitch: UISegmentedControl!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var contentView: UIView!
    var activeVC: ActiveTimersVC = ActiveTimersVC()
    var endedVC: EndedTimersVC = EndedTimersVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewControllerAsView(vc: activeVC)
        self.addChildViewControllerAsView(vc: endedVC)
        self.viewDidLoadyjrOFBestplan("add")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.switchViewController(tabSwitch)
        UIApplication.statusBarBackgroundColor = UIColor.magenta
    }
    @IBAction func switchViewController(_ sender: UISegmentedControl) {
        let tab = sender.selectedSegmentIndex
        let vc_array = self.childViewControllers
        for vc in vc_array{
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
        switch tab {
        case 0:
            self.addChildViewControllerAsView(vc: activeVC)
        case 1:
            self.addChildViewControllerAsView(vc: endedVC)
        default:
           break
        }
    }
    func addChildViewControllerAsView(vc: UIViewController) {
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
        vc.view.frame = self.contentView.bounds
        self.contentView.addSubview(vc.view)
    }
    @IBAction func openSettingVC(_ sender: UIBarButtonItem) {
        self.present(SettingsVC(), animated: true, completion: nil)
    }
    @IBAction func addTimer(_ sender: UIBarButtonItem) {
        let editVC = EditTimerVC.init(timer: GeronimoTimer())
        self.present(editVC, animated: true, completion: nil)        
    }
    func configureSegmentedControl(){
        tabSwitch.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.selected)
        tabSwitch.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.normal)
    }
}
