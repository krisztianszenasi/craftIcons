//
//  CraftColorDirection.swift
//  CraftIconShowcase
//
//  Created by Krisztián Szénási on 2025. 07. 16..
//

import Foundation


enum CraftColorDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case bottomRightToTopLeft
    case topRightToBottomLeft
    case bottomLeftToTopRight

    var startPoint: CGPoint {
        switch self {
        case .topToBottom: return CGPoint(x: 0.5, y: 0.0)
        case .bottomToTop: return CGPoint(x: 0.5, y: 1.0)
        case .leftToRight: return CGPoint(x: 0.0, y: 0.5)
        case .rightToLeft: return CGPoint(x: 1.0, y: 0.5)
        case .topLeftToBottomRight: return CGPoint(x: 0.0, y: 0.0)
        case .bottomRightToTopLeft: return CGPoint(x: 1.0, y: 1.0)
        case .topRightToBottomLeft: return CGPoint(x: 1.0, y: 0.0)
        case .bottomLeftToTopRight: return CGPoint(x: 0.0, y: 1.0)
        }
    }

    var endPoint: CGPoint {
        switch self {
        case .topToBottom: return CGPoint(x: 0.5, y: 1.0)
        case .bottomToTop: return CGPoint(x: 0.5, y: 0.0)
        case .leftToRight: return CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft: return CGPoint(x: 0.0, y: 0.5)
        case .topLeftToBottomRight: return CGPoint(x: 1.0, y: 1.0)
        case .bottomRightToTopLeft: return CGPoint(x: 0.0, y: 0.0)
        case .topRightToBottomLeft: return CGPoint(x: 0.0, y: 1.0)
        case .bottomLeftToTopRight: return CGPoint(x: 1.0, y: 0.0)
        }
    }
}
