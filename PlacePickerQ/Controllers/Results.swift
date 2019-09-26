//
//  Results.swift
//  EV Quiz
//
//  Created by Abraham VG on 18/09/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import Foundation


enum Results<T> {
    case Success(T)
    case Error(String)
}

enum compState {
    case success
    case failed
}
