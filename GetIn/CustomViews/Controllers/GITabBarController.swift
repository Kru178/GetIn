//
//  GITabBarController.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

class GITabBarController: UITabBarController {

    private let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private var dictionary: [ListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createListVC(), createTestVC(), createSettingsVC()]
        selectedIndex = 2
    }
    
    
    private func createListVC() -> UINavigationController {
        let listVC = GIListVC()
        listVC.title = "List"
        listVC.container = container
        
        listVC.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        
        return UINavigationController(rootViewController: listVC)
    }
    
    private func createTestVC() -> UINavigationController {
        let testVC = GITestVC()
        testVC.title = "Test"
        testVC.container = container
        
        testVC.tabBarItem = UITabBarItem(title: "Test", image: UIImage(systemName: "gamecontroller"), selectedImage: UIImage(systemName: "gamecontroller"))
        
        return UINavigationController(rootViewController: testVC)
    }
    
    
    private func createSettingsVC() -> UINavigationController {
        let settingsVC = GISettingsVC()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
      
        return UINavigationController(rootViewController: settingsVC)
    }
    
    private func fetchData() {
        do {
            self.dictionary = try container.viewContext.fetch(ListModel.fetchRequest())
            
        } catch {
            print("cannot read context")
        }
    }
}
