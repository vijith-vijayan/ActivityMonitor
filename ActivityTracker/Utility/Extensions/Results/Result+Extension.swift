//
//  Result+Extension.swift
//  ActivityTracker
//
//  Created by Vijith TV on 27/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import RealmSwift

extension Results {
    
    func arrayValue<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}
