//
//  Configuration.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import Foundation

// enum to prevent typo
enum UserDefaultKeys: String{
    // define if app was used before
    case alreadyUsed = "alreadyUsed"
    // define OK in term of use
    case termOfUseAccepted = "termOfUseAccepted"
}

class Configuration{
    //singleton class
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    private init(){}
    
    // Define if user use the app
    var alreadyUsed: Bool{
        get{
            return defaults.bool(forKey: UserDefaultKeys.alreadyUsed.rawValue)
        }
        set{
            defaults.set(newValue, forKey: UserDefaultKeys.alreadyUsed.rawValue)
        }
    }
    // Define if the user accepeted the term of use
    var termOfUseAccepted: Bool{
        get{
            return defaults.bool(forKey: UserDefaultKeys.termOfUseAccepted.rawValue)
        }
        set{
            defaults.set(newValue, forKey: UserDefaultKeys.termOfUseAccepted.rawValue)
        }
    }
}
