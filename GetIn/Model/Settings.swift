//
//  Settings.swift
//  GetIn
//
//  Created by Sergei Krupenikov on 16.12.2020.
//

enum Section: Int, CaseIterable, CustomStringConvertible {
    case General
    case Notifications
    case Stats
    case Feedback
    
    var description: String {
        
        switch self {
        case .General: return "General"
        case .Notifications: return "Notifications"
        case .Stats: return "Stats"
        case .Feedback: return "Feedback"
        }
    }
}

enum General: Int, CaseIterable, CustomStringConvertible {
    case NumberOfWords
    
    var description: String {
        
        switch self {
        case .NumberOfWords: return "Number of words in test"
        }
    }
}

enum Notifications: Int, CaseIterable, CustomStringConvertible {
    case Notifications
    case Time
    case Sounds
    
    var description: String {
        
        switch self {
        case .Notifications: return "Enable notifications"
        case .Time: return "Time"
        case .Sounds: return "Sounds"
        }
    }
}

enum Stats: Int, CaseIterable, CustomStringConvertible {
    case AllLists
    case AllWords
    case LearnedWords
    
    var description: String {
        
        switch self {
        case .AllLists: return "Overall lists added"
        case .AllWords: return "Overall words added"
        case .LearnedWords: return "Words Learned"
        }
    }
}

enum Feedback: Int, CaseIterable, CustomStringConvertible {
    case Email
    case RateApp
    
    var description: String {
        
        switch self {
        case .Email: return "Contact Us"
        case .RateApp: return "Rate App"
        }
    }
}
