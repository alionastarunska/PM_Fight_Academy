//
//  ValidationServiceTests.swift
//  FightAcademyTests
//
//  Created by Павел Снижко on 20.03.2021.
//

import XCTest
@testable import FightAcademy

class ValidationServiceTests: XCTestCase {
    let validationSerice = Validator()
    
    func testPassword() {
        let successPasswords = ["Qwerty_12345", "FSD333333_i"]
        let wrongPasswords = ["qwerty_12345", "1111111111", "d", "fkljsdlkfjsdflk", "____________", "FDSFDSFSDFSDFSD", "FDFFDSFSDFF", "FSD_333333", " ", "", "32r3423423423423423423"]
        
        successPasswords.forEach {
            do {
                try validationSerice.validate(password: $0)
            } catch let error {
                XCTFail("The validate() was not supposed to throw an error. All passwords were allowed. Was catched \(error.localizedDescription)")
            }
        }
        
        wrongPasswords.forEach{
            do {
                try validationSerice.validate(password: $0)
                XCTFail("The validate() was supposed to throw an error but wasn't")
            } catch let error {
                XCTAssertNotNil(error as? ValidationError)
            }
        }
    }
    
    func testPhoneNumber() {
        let succesPhoneNumbers = ["+380932267630", "+380683351066", "+380503351066", "0932267631"]
        let wrongPhoneNumbers = ["380932267630", "+38093226763", " ", "fsdfds", "+++++++++++++", "+390503351066", "+38+380932267631"]
        
        succesPhoneNumbers.forEach {
            do {
                try validationSerice.validate(phoneNumber: $0)
            } catch let error {
                XCTFail("The validate() was not supposed to throw an error. All numbers were allowed. Was catched \(error.localizedDescription)")
            }
        }
        
        wrongPhoneNumbers.forEach {
            do {
                try validationSerice.validate(phoneNumber: $0)
                
                XCTFail("The validate() was supposed to throw an error but wasn't")
            } catch let error {
                XCTAssertNotNil(error as? ValidationError)
            }
        }
    }
}
