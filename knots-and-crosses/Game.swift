//
//  Game.swift
//  knots-and-crosses
//
//  Created by Ueta, Lucas T on 10/11/23.
//

import Foundation

enum Fill {
    case x, o, empty
}

class Game {
    var grid: [[Fill]] = [] {
        didSet {
            for i in 0...2 {
                if (grid[i][0] == grid[i][1] && grid[i][1] == grid[i][2]) && (grid[i][0] == .x || grid[i][0] == .o) {
                    winner = grid[i][0]
                    return
                }
                if (grid[0][i] == grid[1][i] && grid[1][i] == grid[2][i]) && (grid[0][i] == .x || grid[0][i] == .o) {
                    winner = grid[0][i]
                    return
                }
            }
            if ((grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2]) || (grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0])) && (grid[1][1] == .x || grid[1][1] == .o) {
                winner = grid[1][1]
            }
        }
    }
    var winner: Fill = .empty
    
    init() {
        for _ in 0...2 {
            var column: [Fill] = []
            for _ in 0...2 { column.append(.empty) }
            grid.append(column)
    }}
        
    func play(_ turn: Fill, at tag: Int) {
        grid[tag / 3][tag % 3] = turn
    }
}
