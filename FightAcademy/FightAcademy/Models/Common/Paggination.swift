//
//  Paggination.swift
//  FightAcademy
//
//  Created by Artem Myshkin on 3/25/21.
//

import Foundation

public struct Paggination: Decodable {

    public let page: Int
    public let totalPages: Int
    public let hasPreviousPage: Bool
    public let hasNextPage: Bool

}
