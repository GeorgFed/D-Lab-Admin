//
//  MainTabBarController.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 13.03.2022.
//

import UIKit

final class DLTabBar: UITabBarController {

    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        tabBar.backgroundColor = .background
        tabBar.tintColor = .primary
        tabBar.unselectedItemTintColor = .unselected
        tabBar.backgroundColor = .background
    }
}
