//
//  ValidationServiceTests.swift
//  FightAcademyTests
//
//  Created by Павел Снижко on 20.03.2021.
//

import XCTest
@testable import FightAcademy

class ValidationServiceTests: XCTestCase {
    let validationSerice = DefaultValidationService()
    
    func testPassword() {
        let successPasswords = ["Qwerty_12345", "FSD_333333d"]
        let wrongPasswords = ["qwerty_12345", "1111111111", "d", "fkljsdlkfjsdflk", "____________", "FDSFDSFSDFSDFSD", "FDFFDSFSDFF", "FSD_333333"]
        
        successPasswords.forEach {
            XCTAssert(((try? validationSerice.validate(password: $0)) != nil))
        }
        
        wrongPasswords.forEach{
            let reult = try? validationSerice.validate(password: $0)
        }
    }
    
    func testPhoneNumber() {
        let succesPhoneNumbers = ["+380932267630", "+380683351066", "+380503351066"]
        let wrongPhoneNumbers = ["380932267630", "+38093226763", " ", "fsdfds", "+++++++++++++", "+390503351066"]
        
        succesPhoneNumbers.forEach {
            XCTAssert(validationSerice.validate(phoneNumber: $0))
        }
        wrongPhoneNumbers.forEach {
            XCTAssertFalse(validationSerice.validate(phoneNumber: $0))
        }
    }
}
