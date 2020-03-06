//
//  DateHelpers.swift
//  Task
//
//  Created by Jordan Furr on 3/5/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: self)
    }
}
