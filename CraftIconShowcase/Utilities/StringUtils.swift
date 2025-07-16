//
//  StringUtils.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import Foundation


struct StringUtils {
    static func getInitials(for text: String, limit: Int = 4) -> String {
        let words = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }

        let initials = words.map { word in
            word.first.map { String($0).uppercased() } ?? ""
        }

        return initials.joined().prefix(limit).description
    }
}
