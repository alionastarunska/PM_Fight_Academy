//
//  AuthModelTests.swift
//  FightAcademyTests
//
//  Created by Павел Снижко on 24.03.2021.
//

import XCTest
@testable import FightAcademy

class AuthModelTests: XCTestCase {
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()

    func testRegistrationModelDecoding() {
        let registrationModel = RegistrationModel()
        registrationModel.name = "Lorem"
        registrationModel.password = "Ipsum"
        registrationModel.phoneNumber = "111"

        let encodedData = try? jsonEncoder.encode(registrationModel)

        XCTAssertNotNil(encodedData)

        let str = String(decoding: encodedData!, as: UTF8.self)
        XCTAssertEqual(str, #"{"login":"111","name":"Lorem","password":"Ipsum"}"#)

    }

    func testAuthorizationModelDecoding() {
        let authModel = AuthorizationModel()
        authModel.password = "Ipsum"
        authModel.phoneNumber = "111"

        let encodedData = try? jsonEncoder.encode(authModel)

        XCTAssertNotNil(encodedData)

        let str = String(decoding: encodedData!, as: UTF8.self)
        XCTAssertEqual(str, #"{"login":"111","password":"Ipsum"}"#)

    }
}
