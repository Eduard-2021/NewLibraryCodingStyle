import SwiftUI

public enum StyleСases {
    case camelCase
    case snakeCase
    case kebabCase
    case oneStyle
}

@propertyWrapper public class LibraryCodingStyle {
    private var styleCase: StyleСases
    private var decodingString = ""
    public var wrappedValue: String {
        get {
            return decodingString
        }
        set {
            set(newValue)
        }
    }

     public init(wrappedValue: String, styleCase: StyleСases) {
        self.decodingString = wrappedValue
        self.styleCase = styleCase
    }

    private func set(_ newValue: String) {
        var wordsArray = newValue.split(whereSeparator: {$0 == " "}).map({String($0).lowercased()})
        var resultingString = ""
        switch styleCase {
        case .camelCase:
            wordsArray = wordsArray.map({$0.capitalized})
            resultingString = wordsArray.joined()
        case .snakeCase:
            resultingString = wordsArray.joined(separator: "_")
        case .kebabCase:
            resultingString = wordsArray.joined(separator: "-")
        case .oneStyle:
            var camelCasesnumber = 0
            var snakeCasesnumber = 0
            var kebabCasesnumber = 0
            var standartNewValue = ""

            for letter in newValue {
                switch letter {
                case let letter where ("A"..."Z" ~= letter) || ("А" ... "Я" ~= letter):
                    camelCasesnumber += 1
                    standartNewValue =  standartNewValue + " " + String(letter).lowercased()
                case "_":
                    snakeCasesnumber += 1
                    standartNewValue =  standartNewValue + " "
                case "-":
                    kebabCasesnumber += 1
                    standartNewValue =  standartNewValue + " "
                default:
                    standartNewValue =  standartNewValue + String(letter)
                }
            }
            styleCase = [(camelCasesnumber, StyleСases.camelCase), (snakeCasesnumber, StyleСases.snakeCase),  ( kebabCasesnumber, StyleСases.kebabCase)].sorted(by: {$0.0>$1.0})[0].1
            set(standartNewValue)
            resultingString = decodingString
        }
        decodingString = resultingString
    }
}
