//
//  GITabBarController.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 20.11.2020.
//

//FIXME: bugs
//(done) start test in pick list vc with less than 10 words
//(done) fatal error when you try to start test first launch without change settings count words
//(done) notifications doesn't work
//(done) notifications able to select a specific date
//(done) send email
//(done) highlight exp of word in list
//(done) add change the list for word
//(done) add cancel button to actionsheet in moveAction


//TODO: fix WordModel error
//TODO: refactor throghout code
//FIXME: fix bug add word with one empty field
//TODO: add max limit of exp
//TODO: add feature: highlight learned word in list
//TODO: change adding exp logic
//TODO: add learned list. it shoul be created as soon as the first word riches max rating. the word should be moved there.
//TODO: improve animations of tableviews



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
