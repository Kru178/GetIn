//
//  NotificationScheduleCenter.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 01.05.2021.
//

import Foundation
import NotificationCenter

class NotificationScheduleCenter {
    
    static let shared = NotificationScheduleCenter()
    
    func scheduleNotification(for vc: UIViewController, time: Date) {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        
        let content = UNMutableNotificationContent()
        content.title = "Repetition Time!"
        content.body = "Hey! It's time to repeat something, don't you think?!"
        content.badge = NSNumber(value: 1)
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("adding notification error: \(error)")
            } else {
                guard let safeTime = calendar.date(from: components) else { return }
                vc.showAlert(for: safeTime)
            }
        }
    }
}
