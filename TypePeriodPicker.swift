import UIKit
class TypePeriodPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    let types: [String] = [TimerData.TimerType.down.rawValue, TimerData.TimerType.up.rawValue]
    var timer: GeronimoTimer?
    var period: TimeInterval?
    func setTimer(timer: GeronimoTimer){
        self.timer = timer
    }
    func showTypePicker(completion: @escaping (Bool)->Void){
        let alert = UIAlertController(title: "TimerType", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let pickerFrame = UIPickerView(frame: CGRect(x: 80, y: 30, width: 100, height: 140))
        alert.view.addSubview(pickerFrame)
        pickerFrame.tag = 1
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            completion(false)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let row = pickerFrame.selectedRow(inComponent: 0)
            self.timer?.type = self.types[row]
            if (self.timer?.type) != nil{
                completion(true)
            }
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    func showPeriodPicker(completion: @escaping (Bool)->Void){
        let alert = UIAlertController(title: "Select time", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let timePicker = UIDatePicker(frame: CGRect(x: 40, y: 30, width: 200, height: 140))
        timePicker.datePickerMode = .countDownTimer
        timePicker.tag = 2
        alert.view.addSubview(timePicker)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            completion(false)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            let time = timePicker.countDownDuration
            self.period = time
            if self.period != nil {
                completion(true)
            }
        }))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.timer?.type = types[row]
    }
}
