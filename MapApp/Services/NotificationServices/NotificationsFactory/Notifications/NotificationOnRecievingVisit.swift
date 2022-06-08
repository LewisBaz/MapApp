//
//  NotificationOnRecievingVisit.swift
//  MapApp
//
//  Created by Lewis on 29.05.2022.
//

import UIKit

final class NotificationOnRecievingVisit: NotificationsFactoryCreating {
    
    let locationDescription: String
    
    init(locationDescription: String) {
        self.locationDescription = locationDescription
    }
    
    func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "New visit marked 📍"
        content.body = locationDescription
        content.sound = .default
        return content
    }
    
    func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    }
    
    func sendNotificatioRequest(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: "NotificationOnRecievingVisit",
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
