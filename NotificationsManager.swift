import UIKit
import UserNotifications
class NotificationsManager: NSObject, UNUserNotificationCenterDelegate{
    static let sharedInstance = NotificationsManager()
    let updateLocalDBNotificationID = "updateActiveTimersAtLocalDB"
    func requestUserPermission(){
        configureNotificationCenter()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if(granted == true){
            } else{
                let alert = UIAlertController(title: "Notification Access", message: "In order to use this application, turn on notification permission in Settings app.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    static func check_notification_permission() -> Bool {
        var result = false
       UNUserNotificationCenter.current().getNotificationSettings{ (settings) in
        if settings.authorizationStatus == .authorized{
            result = true
        } else {
            result = false
        }
        }
        return result
    }
    func configureNotificationCenter(){
        UNUserNotificationCenter.current().delegate = self
        let actionLater = UNNotificationAction(identifier: NotificationActionsID.later.rawValue, title: NotificationActionsTitles.later.rawValue, options: [])
        let actionConfirm = UNNotificationAction(identifier: NotificationActionsID.confirm.rawValue, title: NotificationActionsTitles.confirm.rawValue, options: [.foreground])
        let tutorialCategory = UNNotificationCategory(identifier: NotificationCategory.name.rawValue, actions: [actionLater, actionConfirm], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([tutorialCategory])
    }
    func sendNotification(timer: GeronimoTimer) {
        if(NotificationsManager.check_notification_permission()){
            let content = UNMutableNotificationContent()
            content.title = timer.name
            content.body = timer.timerDescription
            content.badge = 1
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = NotificationCategory.name.rawValue
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timer.period, repeats: true)
            if let id = timer.lastNotificationID{
                let request = UNNotificationRequest(identifier: id , content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                print("Notification request added succesfully")
            }
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification_ID = response.notification.request.identifier
        if let timer: TimerRealm = DBManager.sharedInstance.getTimerByNotificationID(id: notification_ID){
            timer.last_alarm_time = Date()
            DBManager.sharedInstance.addTimer(object: timer)
        }
        switch response.actionIdentifier {
        case NotificationActionsID.later.rawValue:
            print("Later button pressed")
        case NotificationActionsID.confirm.rawValue:
            print("Timer confirmed")
            let notification_ID = response.notification.request.identifier
            confirmTimer(timerNotificationID: notification_ID)
            UIApplication.shared.applicationIconBadgeNumber = 0
        default:
            print("Other Action")
        }
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
        let notification_ID = notification.request.identifier
        if let timer: TimerRealm = DBManager.sharedInstance.getTimerByNotificationID(id: notification_ID){
            timer.last_alarm_time = Date()
            DBManager.sharedInstance.addTimer(object: timer)
        }
    }
    func randomString(length: Int = 15) -> String{
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    func confirmTimer(timerNotificationID: String){
        if let active_timer = DBManager.sharedInstance.getTimerByNotificationID(id: timerNotificationID){
           active_timer.succesCount = active_timer.succesCount + 1
            DBManager.sharedInstance.addTimer(object: active_timer)
            if let ended_timer = DBManager.sharedInstance.getEndedTimerByID(timerID: active_timer.id){
                DBManager.sharedInstance.deleteEndedTimerById(timer_id: ended_timer.id)
            }
        }
    }
}
