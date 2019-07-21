import UIKit
import StoreKit
import MessageUI
class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var settingTable: UITableView!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    let cellName = "SettingsTableCell"
    let about = AboutVC()
    let firstSection = ["New Feature Reuest", "Performance Feedback", "Report a Bug","E-mail"]
    let secondSection = ["About Us","Share","Rate on App Store"]
    let sectionHeaderTitleArray = ["FEEDBACK","MORE"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingTable()
        self.configureSettingTableNpqAnBestplan("stagePlan")
    }
    override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
        for constraint in self.settingTable.constraints {
            if constraint.identifier == "tableHeight" {
                constraint.constant = self.settingTable.contentSize.height
            }
        }
    }
    func configureSettingTable(){
        settingTable.register(UINib(nibName: cellName, bundle: Bundle.main), forCellReuseIdentifier: cellName)
        settingTable.delegate = self
        settingTable.dataSource = self
        settingTable.rowHeight = 43.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! SettingsTableCell
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:
            cell.updateCell(name: firstSection[indexPath.row])
        case 1:
            cell.updateCell(name: secondSection[indexPath.row])
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 30, y: 0, width:
            settingTable.bounds.size.width, height: 30))
        let label = UILabel(frame: CGRect.init(x: 20, y: 15, width: settingTable.bounds.size.width, height: 20))
        label.text = self.sectionHeaderTitleArray[section]
        label.textColor = UIColor.darkGray
        label.font = label.font.withSize(12)
        returnedView.addSubview(label)
        returnedView.backgroundColor = UIColor.groupTableViewBackground
        return returnedView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row_count = 0
        switch section {
        case 0:
            row_count = firstSection.count
        case 1:
            row_count = secondSection.count
        default:
            break
        }
        return row_count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let sendVC = SendFormVC()
            switch indexPath.row {
            case 0:
                sendVC.screenName = "New Feature"
                self.present(sendVC, animated: true, completion: nil)
            case 1:
                sendVC.screenName = "Feedback"
                self.present(sendVC, animated: true, completion: nil)
            case 2:
                sendVC.screenName = "Bug Report"
                self.present(sendVC, animated: true, completion: nil)
            case 3:
                self.btnContactUsClicked()
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.present(self.about, animated: true, completion: nil)
            case 1:
                self.btnShareClicked()
            case 2:
                self.btnRateAppClicked()
            default:
                break
            }
        default:
            break
        }
    }
    func btnContactUsClicked()
    {
        if !MFMailComposeViewController.canSendMail() {
            self.showSendMailErrorAlert()
            return
        }
        else
        {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            composeVC.setToRecipients(["jsonkeny@gmail.com"])
            composeVC.setSubject("MythicalGods - Contact Us")
            composeVC.setMessageBody("Please message us your feedback and questions", isHTML: true)
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        let actionForAlert = UIAlertAction(title: "OK", style: .default)
        sendMailErrorAlert.addAction(actionForAlert)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissSettingsVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func btnShareClicked()
    {
        let message = "Check out this app!! "
        let url = "http://itunes.apple.com/app/id" + "1473724920"
        if let link = NSURL(string: url)
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            if let popoverController = activityVC.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: self.view.bounds.width, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    func btnRateAppClicked(){
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            print("Version less than 10.3")
        }
    }
}
