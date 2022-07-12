//
//  ChessPiece.swift
//  Chess
//
//  Created by Apple on 23.06.2022.
//

import Foundation

struct ChessPiece: Hashable {
    let col: Int
    let row: Int
    let imageName: String
    let isWhite: Bool
}
