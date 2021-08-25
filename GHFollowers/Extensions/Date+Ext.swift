//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Alejandro Trejo on 18/08/21.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
