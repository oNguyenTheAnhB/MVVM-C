//
//  String+Ext.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/15/21.
//

import Foundation

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
