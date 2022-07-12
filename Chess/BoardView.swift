//
//  BoardView.swift
//  Chess
//
//  Created by Apple on 22.06.2022.
//

import UIKit

class BoardView: UIView {

    let ratio: CGFloat = 1.0
    var coordinateX: CGFloat = -1
    var coordinateY: CGFloat = -1
    var sizeCell: CGFloat = -1
    
    var shadowPieces: Set<ChessPiece> = Set<ChessPiece>()
    var chessDelegate: ChessDelegate? = nil
    
    var fromCol: Int? = nil
    var fromRow: Int? = nil
    
    var movingImage: UIImage? = nil
    var movingPieceX: CGFloat = -1
    var movingPieceY: CGFloat = -1
    
    override func draw(_ rect: CGRect) {
        sizeCell = bounds.width * ratio / 8
        coordinateX = bounds.width * (1 - ratio) / 2
        coordinateY = bounds.height * (1 - ratio) / 2
        
        drawBoard()
        drawPieces()
    }
    
//MARK: -Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        fromCol = Int((fingerLocation.x - coordinateX) / sizeCell)
        fromRow = Int((fingerLocation.y - coordinateX) / sizeCell)
        
        if let fromCol = fromCol, let fromRow = fromRow, let movingPiece = chessDelegate?.pieceAt(col: fromCol, row: fromRow) {
            movingImage = UIImage(named: movingPiece.imageName)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        movingPieceX = fingerLocation.x
        movingPieceY = fingerLocation.y
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let first = touches.first!
        let fingerLocation = first.location(in: self)
        
        let toCol = Int((fingerLocation.x - coordinateX) / sizeCell)
        let toRow = Int((fingerLocation.y - coordinateX) / sizeCell)
        
        if let fromCol = fromCol, let fromRow = fromRow, fromCol != toCol || fromRow != toRow {
            chessDelegate?.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        }
        movingImage = nil
        fromCol = nil
        fromRow = nil
        
        setNeedsDisplay()
    }
    
    func drawPieces() {
        for piece in shadowPieces where fromCol != piece.col || fromRow != piece.row {
            let piecesImage = UIImage(named: piece.imageName)
            piecesImage?.draw(in: CGRect(x: coordinateX + (CGFloat(piece.col) * sizeCell),
                                          y: coordinateY + (CGFloat(piece.row) * sizeCell),
                                          width: sizeCell, height: sizeCell))
        }
        
        movingImage?.draw(in: CGRect(x: movingPieceX - sizeCell/2, y: movingPieceY - sizeCell/2, width: sizeCell, height: sizeCell))
    }
    
    func drawBoard() {
        for row in 0..<4 {
            for col in 0..<4 {
                drawSquare(col:  col * 2, row: row * 2, color: UIColor.white)
                drawSquare(col: (col * 2) + 1, row: row * 2, color: UIColor.black)
                
                drawSquare(col:  col * 2, row: (row * 2) + 1, color: UIColor.black)
                drawSquare(col: (col * 2) + 1, row: (row * 2) + 1, color: UIColor.white)
            }
        }
    }

    func drawSquare(col: Int, row: Int, color: UIColor) {
        let path = UIBezierPath(rect: CGRect(x: coordinateX + (CGFloat(col) * sizeCell),
                                             y: coordinateY + (CGFloat(row) * sizeCell),
                                             width: sizeCell, height: sizeCell))
        color.setFill()
        path.fill()
    }

}
