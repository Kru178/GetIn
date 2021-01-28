//
//  GITabBarController.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

//(done) start test in pick list vc with less than 10 words
//(done) fatal error when you try to start test first launch without change settings count words
//(done) notifications doesn't work
//(done) notifications able to select a specific date
//(done) send email
//(done) highlight exp of word in list
//(done) add change the list for word
//(done) add cancel button to actionsheet in moveAction
//(done): fix bug add word with one empty field
//(done): add max limit of exp
//(done): add feature: highlight learned word in list
//(done): change adding exp logic
//(done) add deletion confirmation
//(done): rate app button
//(done): add some stats like total learned words << improve stats calculation


//TODO: fix WordModel error
//TODO: refactor throghout code
//TODO: improve animations of tableviews
//TODO: change opened list when user select another tab and get back
//TODO: get some order rule for words list
//TODO: return words from learned
//TODO: save to iCloud
//TODO: create the app icon


import UIKit

class GITabBarController: UITabBarController {

    private let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private var dictionary: [ListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createListVC(), createTestVC(), createSettingsVC()]
        selectedIndex = 0
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
        settingsVC.container = container
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear"))
      
        return UINavigationController(rootViewController: settingsVC)
    }
    
    private func fetchData() {
        do {
            dictionary = try container.viewContext.fetch(ListModel.fetchRequest())
            
        } catch {
            print("cannot read context")
        }
    }
}
