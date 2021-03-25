//
//  Paggination.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

public struct Paggination: Decodable {

    public var page: Int
    public var totalPages: Int
    public var hasPreviousPage: Bool
    public var hasNextPage: Bool

}
