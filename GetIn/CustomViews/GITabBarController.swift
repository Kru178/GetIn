//
//  GITabBarController.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

import UIKit

class GITabBarController: UITabBarController {

    var inputData = DictionaryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //test initital default vacabulary
        let word = WordModel(word: "hello", translation: "Привет")
        let list = List(title: "Default list")
        let list2 = List(title: "Second")
        list.words.append(word)
        inputData.vocabulary.append(list)
        inputData.vocabulary.append(list2)
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createListVC(), createAddWordVC(), createTestVC(), createSettingsVC()]
        selectedIndex = 2
    }
    
    
    func createListVC() -> UINavigationController {
        let listVC = GIListVC()
        listVC.title = "List"
        listVC.dictionaryModel = inputData
        
        listVC.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        
        return UINavigationController(rootViewController: listVC)
    }

    
    func createAddWordVC() -> UINavigationController {
        let addWordVC = GIAddWordVC()
        addWordVC.title = "Add Word"
        addWordVC.dictionaryModel = inputData
        
        addWordVC.tabBarItem = UITabBarItem(title: "Add Word", image: UIImage(systemName: "square.and.pencil"), selectedImage: UIImage(systemName: "square.and.pencil"))
        
        return UINavigationController(rootViewController: addWordVC)
    }
    
    
    func createTestVC() -> UINavigationController {
        let testVC = GITestVC()
        testVC.title = "Test"
        testVC.dictionaryModel = inputData
        
        testVC.tabBarItem = UITabBarItem(title: "Test", image: UIImage(systemName: "gamecontroller"), selectedImage: UIImage(systemName: "gamecontroller"))
        
        return UINavigationController(rootViewController: testVC)
    }
    
    
    func createSettingsVC() -> UINavigationController {
        let settingsVC = GISettingsVC()
        settingsVC.title = "Settings"
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
      
        return UINavigationController(rootViewController: settingsVC)
    }
}
