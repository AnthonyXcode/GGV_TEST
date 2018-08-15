//
//  RecordDoc.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 15/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import Foundation
import RealmSwift

class RecodDoc: Object {
    @objc dynamic var name = ""
    @objc dynamic var timeSpent = 0.0
    @objc dynamic var maxTime = 0.0
}
