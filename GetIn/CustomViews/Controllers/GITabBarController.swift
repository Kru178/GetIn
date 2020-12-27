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
        
        fillDictionary()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createListVC(), createTestVC(), createSettingsVC()]
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
        addWordVC.title = "Translate"
        addWordVC.dictionaryModel = inputData
        
        addWordVC.tabBarItem = UITabBarItem(title: "Translate", image: UIImage(systemName: "globe"), selectedImage: UIImage(systemName: "globe"))
        
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
    
    func fillDictionary() {
        //test initital default vocabulary
        let word1 = WordModel(word: "hello", translation: "Привет")
        let word2 = WordModel(word: "default", translation: "По умолчанию")
        let word3 = WordModel(word: "yellow", translation: "желтый")
        let word4 = WordModel(word: "white", translation: "белый")
        let word5 = WordModel(word: "black", translation: "черный")
        let word6 = WordModel(word: "father", translation: "отец")
        let word7 = WordModel(word: "mother", translation: "мать")
        let word8 = WordModel(word: "brother", translation: "брат")
        let word9 = WordModel(word: "sister", translation: "сестра")
        let word10 = WordModel(word: "sun", translation: "солнце")
        let word11 = WordModel(word: "back", translation: "назад")
        let word12 = WordModel(word: "ahead", translation: "впереди")
        let word13 = WordModel(word: "head", translation: "голова")

        word1.exp = 10
        word2.exp = 20
        word3.exp = 30
        word4.exp = 40
        word5.exp = 50
        word6.exp = 60
        word7.exp = 130
        word8.exp = 120
        word9.exp = 110
        word10.exp = 100
        word11.exp = 90
        word12.exp = 80
        word13.exp = 70

        let list = List(title: "Default list")
        let list2 = List(title: "Second")

        list.words.append(word1)
        list.words.append(word2)
        list.words.append(word3)
        list.words.append(word4)
        list.words.append(word5)
        list.words.append(word6)
        list.words.append(word7)

        list2.words.append(word8)
        list2.words.append(word9)
        list2.words.append(word10)
        list2.words.append(word11)
        list2.words.append(word12)
        list2.words.append(word13)

        inputData.vocabulary.append(list)
        inputData.vocabulary.append(list2)
    }
}
