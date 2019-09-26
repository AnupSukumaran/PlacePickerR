//
//  Localizer.swift
//  Localization102
//
//  Created by Moath_Othman on 2/24/16.
//  Copyright © 2016 Moath_Othman. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func isRTL() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

class L102Localizer: NSObject {
    class func DoTheMagic() {
        
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        
        MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
        
        MethodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.layoutSubviews), overrideSelector: #selector(UIButton.cstmlayoutSubviews))
        
       // assignErrorMsg()

    }
    
//  class func assignErrorMsg() {
//
//        switch L102Language.currentAppleLanguage()  {
//        case "ar":
//            textFieldErrorArbMsg()
//        case "en":
//            textFieldErrorEngMsg()
//        default:
//            break
//        }
//
//    }
    
//  class func textFieldErrorEngMsg() {
//        gVal.REQUIRED_RULE = UITextCont.thisFieldIsReq
//        gVal.EMAIL_RULE = UITextCont.mustBeValidadd
//        gVal.PASSWORD_RULE = UITextCont.mustBeEight
//        gVal.CONFIRMATION_RULE = UITextCont.notAMatch
//    }
//
//  class func textFieldErrorArbMsg() {
//        gVal.REQUIRED_RULE = UITextCont.arbthisFieldIsReq
//        gVal.EMAIL_RULE = UITextCont.arbmustBeValidadd
//        gVal.PASSWORD_RULE = UITextCont.arbmustBeEight
//        gVal.CONFIRMATION_RULE = UITextCont.arbnotAMatch
//    }
}


extension UIButton {
    @objc public func cstmlayoutSubviews() {
        
        self.cstmlayoutSubviews()
//        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
//
//            return // handle special case with uitextfields
//        }
        
        if self.tag < 0  {
            
            if UIApplication.isRTL()  {
                
                 self.semanticContentAttribute = .forceLeftToRight
                if self.titleLabel?.textAlignment == .right {
                    return
                }
                
            } else {
                
                if self.titleLabel?.textAlignment == .left {
                    return
                }
            }
        }
        
        if self.tag < 0 {
            
            if UIApplication.isRTL()  {
                self.titleLabel?.textAlignment = .right
            } else {
                self.titleLabel?.textAlignment = .left
            }
        }
        
    }
}

extension UILabel {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            Logger.pnt("Test123 - is UITextFieldLabel")
            return // handle special case with uitextfields
        }
        Logger.pnt("Test123 -is UILabel")
        if self.tag < 0  {
            if UIApplication.isRTL()  {
                Logger.pnt("Test123 - is UILabel is right")
                if self.textAlignment == .right {
                    return
                }
            } else {
                 Logger.pnt("Test123 - is UILabel is left")
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag < 0 {
            if UIApplication.isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}


extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
       
        if self.tag < 0 {
            if UIApplication.isRTL()  {
                
                if self.textAlignment == .right { return }
                self.textAlignment = .right
                
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}


var numberoftimes = 0
extension UIApplication {
    @objc  var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if L102Language.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}



extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            
            let currentLanguage = L102Language.currentAppleLanguage()
            
            var bundle = Bundle()
            
            if let _path = Bundle.main.path(forResource: L102Language.currentAppleLanguageFull(), ofType: "lproj") {
                
                bundle = Bundle(path: _path)!
                
            } else if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                
                bundle = Bundle(path: _path)!
                
            } else {
                
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)!
                
            }
            
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
            
        } else {
            
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
            
        }
    }
}
func disableMethodSwizzling() {
    
}


/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector) else {Logger.pnt("origMethod😩");return}
    guard let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) else {Logger.pnt("origMethod😩");return}
    
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
