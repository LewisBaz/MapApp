//
//  LocalNotificationsService.swift
//  MapApp
//
//  Created by Lewis on 28.05.2022.
//

import UserNotifications
import UIKit

final class LocalNotificationsService {
    
    private let notificationsCenter = UNUserNotificationCenter.current()
    private let notificationsFactory = NotificationsFactory()
    
    var isGranted = false
    
    func grantAccessToNotifications() {
        notificationsCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            guard let self = self else { return }
            if granted {
                print("Notifications granted")
                self.isGranted = true
                let notification = self.notificationsFactory.createNotification(essense: .notificationOnAppClose)
                notification.sendNotificatioRequest(content: notification.makeNotificationContent(),
                                                    trigger: notification.makeIntervalNotificatioTrigger())
            } else {
                print("Notifications not granted")
                self.isGranted = false
            }
        }
    }
    
    func checkIsAccessToNotificationsGranted() {
        notificationsCenter.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            switch settings.authorizationStatus {
            case .authorized:
                print("Notifications authorized")
                self.isGranted = true
            case .denied:
                print("Notofications denied")
                self.isGranted = false
            case .ephemeral:
                print("Notifications authorized for limited time")
                self.isGranted = true
            case .provisional:
                print("Notifications should not be interruptive")
                self.isGranted = true
            case .notDetermined:
                print("Notifications not determined")
                self.isGranted = false
            @unknown default:
                print("Notifications authrization error")
                self.isGranted = false
            }
        }
    }
}
