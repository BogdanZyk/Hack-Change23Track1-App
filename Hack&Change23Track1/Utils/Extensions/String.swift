//
//  String.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 25.11.2023.
//

import Foundation

extension String {
    
    var isEmail: Bool {
       let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
       let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
       return emailTest.evaluate(with: self)
    }
        
    var noSpaceStr: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isEmptyStrWithSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
