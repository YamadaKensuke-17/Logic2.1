import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class AlarmClock {
    private var timer: Timer?
    private var alarmDate: Date?
    
    func setAlarm(hour: Int, minute: Int) {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        components.second = 0
        
        alarmDate = Calendar.current.date(from: components)! // nillになる可能性がほとんどないと思ったので強制アンラップにしました。
        print(String(format:"⏰ アラームをセットしました。 %02d:%02d", hour, minute))
        start()
    }
    
    private func start() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(checkAlarm),
            userInfo: nil,
            repeats: true
            
        )
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc func checkAlarm() {
        guard let alarmDate = alarmDate else { return }
        
        let now = Date()
        let calendar = Calendar.current
        
        let nowHour = calendar.component(.hour, from: now)
        let nowMinute = calendar.component(.minute, from: now)
        
        let alarmHour = calendar.component(.hour, from: alarmDate)
        let alarmMinute = calendar.component(.minute, from: alarmDate)
        
        if nowHour == alarmHour && nowMinute == alarmMinute {
            print("🔔 ジリリリリ！起きる時間です！")
            timer?.invalidate()
        }
    }
}


let alarm = AlarmClock()
alarm.setAlarm(hour: 11, minute: 6)


