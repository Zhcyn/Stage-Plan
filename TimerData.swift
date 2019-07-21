import UIKit
struct TimerData {
    var currentDate: Date = Date()
    enum TimerType: String {
        case up = "Up"
        case down = "Down"
    }
}
