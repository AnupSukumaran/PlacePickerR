//
//  Logger.swift
//  LogginTut
//
//  Created by Sukumar Anup Sukumaran on 23/03/19.
//  Copyright © 2019 Qaptive_Technologies. All rights reserved.
//

import os.log

class Logger {
    
    static let showPrintValue = false
    
    enum types: String {
        case info =  "LOG"
        case warning =  "WARNING"
        case error = "ERROR"
    }
    
    enum Component {
        case file
        case function
        case line
        
        func enabled() -> Bool {
            return Logger.components.contains(self)
        }
    }

    static var components: [Component] = [.file,.function,.line]
    
    static func pnt(_ msg: String,_ function: String = #function,_ line: Int = #line ) {
        
        #if DEBUG
        if showPrintValue {
            print("Func -> \(function),line -> \(line)👇 \n Result -> \(msg)")
        }
        #endif
        
    }
    
}
