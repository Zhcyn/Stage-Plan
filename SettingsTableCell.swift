import UIKit
class SettingsTableCell: UITableViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func updateCell(name: String){
        self.cellLabel.text = name
    }
}
