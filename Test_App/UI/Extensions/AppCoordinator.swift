//
//  AppCoordinator.swift
//  Test_App
//
//  Created by Georgie Muler on 17.06.2022.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = FileViewController.createFromStoryboard()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.title = "/"
        self.navigationController = navigationController
        viewController.coordinator = self
        window.rootViewController = navigationController
    }
}

extension AppCoordinator: FileNavigation {
    
    func showFolder(with file: File,
                    viewType: FileViewController.ViewType) {
        
        let isNeedToToggleViewType = viewType == .icon
        
        let viewController = FileViewController.createFromStoryboard()
        viewController.title = file.name
        viewController.configure(with: self,
                                 currentPath: file.id,
                                 isNeedToToggleViewType: isNeedToToggleViewType)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
