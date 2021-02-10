//
//  StoringData.swift
//  UTS-iOS-BubblePop
//
//  Created by user164045 on 6/28/20.
//  Copyright © 2020 user164045. All rights reserved.
//

import Foundation

struct Database: Codable
{
     let target: URL
     let board: URL
    
    enum GError: Error {
        case noData
        case noSavedData
    }
    
    init()
    {
        let dict = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        target = dict.appendingPathComponent("target")
            .appendingPathExtension("json")
        board = dict.appendingPathComponent("leaderboard")
            .appendingPathExtension("json")
    }
    
    // Data Storage
    func recordStorage (scores: [LeaderViewController]) throws {
        let metaData = try JSONEncoder().encode(scores)
        try recordWrite(metaData, to: board)
    }
    
   
    
    func recordRead(from archive: URL) throws -> Data
    {
        if let metaData = try? Data(contentsOf: archive)
        {
            return metaData
        }
        throw GError.noData
    }
    
    func recordWrite(_ unit: Data, to archive: URL) throws {
        do {
            try unit.write(to: archive, options: .noFileProtection)
        }
        catch {
            throw GError.noSavedData
        }
    }
    
    
    func leadRecords() throws -> [LeaderViewController] {
        let metaData = try recordRead(from: board)
        if let unit = try? JSONDecoder().decode([LeaderViewController].self, from: metaData) {
            return unit
        }
        throw GError.noData
    }
    
}
