//
//  Theme.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 10/03/2022.
//

import Foundation
import UIKit

class Theme: NSObject{
    
    public static let shared = Theme()
    
    var theme: ThemeModel? = ThemeModel(primaryColor: .black, secondaryColor: .white, textColor: .black, requiredColor: .red, buttonTextColor: .white)
    
    fileprivate override init(){
    }
    
}

struct ThemeModel{
    var primaryColor: UIColor
    var secondaryColor: UIColor
    var textColor: UIColor
    var requiredColor: UIColor
    var buttonTextColor: UIColor
    
}
