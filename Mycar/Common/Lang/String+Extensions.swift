//
//  String+Extensions.swift
//  Mycar
//
//  Created by Roberto Filho on 19/03/23.
//

import Foundation

extension String {
    
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            
            cur += 1
        }
        return nil
    }
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format:"SELF MATCHES %@", regEx).evaluate(with: self)
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        
        // validar a data
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        //Date -> yyyy-MM-dd -> String
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
    
    func toDate(sourcePattern source: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
}
