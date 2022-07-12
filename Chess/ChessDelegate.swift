//
//  ChessDelegate.swift
//  Chess
//
//  Created by Apple on 26.06.2022.
//

import Foundation

protocol ChessDelegate {
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int)
    func pieceAt(col: Int, row: Int) -> ChessPiece?
}
