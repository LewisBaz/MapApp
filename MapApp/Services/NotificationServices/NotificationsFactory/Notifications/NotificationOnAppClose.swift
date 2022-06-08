//
//  NotificationOnAppClose.swift
//  MapApp
//
//  Created by Lewis on 28.05.2022.
//

import UIKit

final class NotificationOnAppClose: NotificationsFactoryCreating {
    
    func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Attention!"
        content.subtitle = "This is notification on close app"
        content.body = "Return and keep using this app!"
        content.sound = .defaultCritical
        return content
    }
    
    func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: 1800, repeats: false)
    }
    
    func sendNotificatioRequest(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: "NotificationOnAppClose",
                                            content: content,
                                            trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
