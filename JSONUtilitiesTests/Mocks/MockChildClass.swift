//
//  MockChildClass.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 22/11/2015.
//  Copyright © 2015 TechBrewers LTD. All rights reserved.
//

import Foundation

@testable import JSONUtilities

final class MockChildClass {
  let string: String
  let integer: Int
  let double: Double
  let bool: Bool
  
  init(
    string: String,
    integer: Int,
    double: Double,
    bool: Bool
    )
  {
    self.string = string
    self.integer = integer
    self.double = double
    self.bool = bool
  }
}

extension MockChildClass : Decodable {
  convenience init(jsonDictionary: JSONDictionary) throws {
    let decoder = JSONDecoder(jsonDictionary: jsonDictionary)
    self.init(
      string : try decoder.decode("stringKey"),
      integer : try decoder.decode("integerKey"),
      double : try decoder.decode("doubleKey"),
      bool : try decoder.decode("boolKey")
    )
  }
}

// MARK: Extensions necessary for testing

extension MockChildClass : Equatable {}

func == (lhs: MockChildClass, rhs: MockChildClass) -> Bool {
  return lhs.string == rhs.string &&
    lhs.integer == rhs.integer &&
    lhs.double == rhs.double &&
    lhs.bool == rhs.bool
}