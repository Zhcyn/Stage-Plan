import UIKit
class GeronimoTimer{
    var id: Int = -1
    var isNew: Bool = true
    var name: String = ""
    var timerDescription: String = ""
    var type: String = TimerData.TimerType.down.rawValue
    var period: TimeInterval = 3600 
    var timeToNextAlarm: TimeInterval = 3600
    var isEnabled = true
    var isNow: Bool = true
    var beginDate: Date = Calendar.current.date(byAdding: .minute, value: 5, to: TimerData().currentDate)!
    var isInfinetily: Bool = true
    var repeats: Int = 1
    var isNever: Bool = true
    var endDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: TimerData().currentDate)!
    var isOnlyWorked = false
    var beginWorkTime: Date = TimerData().currentDate
    var endWorkTime: Date = Calendar.current.date(byAdding: .hour, value: 1, to: TimerData().currentDate)!
    var succesCount = 0
    var failCount = 0
    var last_alarm_time: Date?
    var lastNotificationID: String?
    convenience init(timer_realm: TimerRealm) {
        self.init()
        self.id = timer_realm.id
        self.isNew = timer_realm.isNew
        self.name = timer_realm.name
        self.timerDescription = timer_realm.timerDescription
        self.type = timer_realm.type
        self.period = timer_realm.period
        self.timeToNextAlarm = self.calculate_timeToNextAlarmFromDB(timer: timer_realm)
        self.isEnabled = timer_realm.isEnabled
        self.isNow = timer_realm.isNow
        self.beginDate = timer_realm.beginDate
        self.isInfinetily = timer_realm.isInfinetily
        self.repeats = timer_realm.repeats
        self.isNever = timer_realm.isNever
        self.endDate = timer_realm.endDate
        self.isOnlyWorked = timer_realm.isOnlyWorked
        self.beginWorkTime = timer_realm.beginWorkTime
        self.endWorkTime = timer_realm.endWorkTime
        self.succesCount = timer_realm.succesCount
        self.failCount = timer_realm.failCount
        self.last_alarm_time = timer_realm.last_alarm_time
        self.lastNotificationID = timer_realm.lastNotificationID
    }
}
