//
//  NotificationsFactory.swift
//  MapApp
//
//  Created by Lewis on 28.05.2022.
//

import UIKit

enum NotificationEssense {
    case notificationOnAppClose
    case notificationOnRecievingVisit
}

protocol NotificationsFactoryCreating {
    func makeNotificationContent() -> UNNotificationContent
    func makeIntervalNotificatioTrigger() -> UNNotificationTrigger
    func sendNotificatioRequest(content: UNNotificationContent, trigger: UNNotificationTrigger)
}

final class NotificationsFactory {
    
    private var locationDescription: String?
    
    convenience init(locationDescription: String) {
        self.init()
        self.locationDescription = locationDescription
    }
    
    func createNotification(essense: NotificationEssense) -> NotificationsFactoryCreating {
        switch essense {
        case .notificationOnAppClose:
            return NotificationOnAppClose()
        case .notificationOnRecievingVisit:
            return NotificationOnRecievingVisit(locationDescription: locationDescription ?? "")
        }
    }
}
