//
//  BaseStoryboardCoordination.swift
//  MapApp
//
//  Created by Lewis on 04.05.2022.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifiable { }

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("View controller с идентификатором \(T.storyboardIdentifier) не найден")
        }
        return viewController
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("View controller с идентификатором \(T.storyboardIdentifier) не найден")
        }
        return viewController
    }
}
