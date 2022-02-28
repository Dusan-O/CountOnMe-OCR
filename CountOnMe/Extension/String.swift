//
//  String.swift
//  CountOnMe
//
//  Created by Dusan Orescanin on 24/02/2022.
//

import Foundation

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
