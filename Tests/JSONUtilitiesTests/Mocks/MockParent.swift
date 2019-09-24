//
//  MockParent.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 15/05/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation
@testable import JSONUtilities

private let randomKey = "asdfghj"

struct MockParent {

  enum MockEnum: String {
    case one
    case two
  }

  // MARK: JSON raw types and custom objects properties
  let mandatoryString: String
  let mandatoryInt: Int
  let mandatoryDouble: Double
  let mandatoryBool: Bool
  let mandatoryWeakDictionaryKey: JSONDictionary
  let mandatoryCustomJSONObject: MockChild
  let mandatoryEnum: MockEnum

  let optionalExistingString: String?
  let optionalExistingInt: Int?
  let optionalExistingDouble: Double?
  let optionalExistingBool: Bool?
  let optionalExistingWeakDictionaryKey: JSONDictionary?
  let optionalExistingCustomJSONObject: MockChild?
  let optionalExistingEnum: MockEnum?

  let optionalMissingString: String?
  let optionalMissingInt: Int?
  let optionalMissingDouble: Double?
  let optionalMissingBool: Bool?
  let optionalMissingWeakDictionaryKey: JSONDictionary?
  let optionalMissingCustomJSONObject: MockChild?
  let optionalMissingEnum: MockEnum?

  // MARK: Array properties
  let mandatoryArrayString: [String]
  let mandatoryArrayInt: [Int]
  let mandatoryArrayDouble: [Double]
  let mandatoryArrayBool: [Bool]
  let mandatoryWeakDictionaryArrayKey: [JSONDictionary]
  let mandatoryArrayCustomJSONObject: [MockChild]

  let optionalExistingArrayString: [String]?
  let optionalExistingArrayInt: [Int]?
  let optionalExistingArrayDouble: [Double]?
  let optionalExistingArrayBool: [Bool]?
  let optionalExistingWeakDictionaryArrayKey: [JSONDictionary]?
  let optionalExistingArrayCustomJSONObject: [MockChild]?

  let optionalMissingArrayString: [String]?
  let optionalMissingArrayInt: [Int]?
  let optionalMissingArrayDouble: [Double]?
  let optionalMissingArrayBool: [Bool]?
  let optionalMissingWeakDictionaryArrayKey: [JSONDictionary]?
  let optionalMissingArrayCustomJSONObject: [MockChild]?

  let mandatoryIntDictionary: [String: Int]
  let mandatoryObjectDictionary: [String: MockChild]
  let mandatoryURLDictionary: [String: URL]
  let optionalIntDictionary: [String: Int]?
  let optionalObjectDictionary: [String: MockChild]?
  let optionalURLDictionary: [String: URL]?

  init(jsonDictionary: JSONDictionary) throws {
    mandatoryString = try jsonDictionary.json(atKeyPath: "keypath.mandatoryStringKey")
    mandatoryInt = try jsonDictionary.json(atKeyPath: "keypath.mandatoryIntKey")
    mandatoryDouble = try jsonDictionary.json(atKeyPath: "keypath.mandatoryDoubleKey")
    mandatoryBool = try jsonDictionary.json(atKeyPath: "keypath.mandatoryBoolKey")
    mandatoryWeakDictionaryKey = try jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    mandatoryCustomJSONObject = try jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    mandatoryEnum = try jsonDictionary.json(atKeyPath: "keypath.mandatoryEnum")

    optionalExistingString = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryStringKey")
    optionalExistingInt = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryIntKey")
    optionalExistingDouble = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryDoubleKey")
    optionalExistingBool = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryBoolKey")
    optionalExistingWeakDictionaryKey = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    optionalExistingCustomJSONObject = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryCustomJSONObjectKey")
    optionalExistingEnum = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryEnum")

    optionalMissingString = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingInt = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingDouble = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingBool = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingWeakDictionaryKey = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingCustomJSONObject = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingEnum = try? jsonDictionary.json(atKeyPath: randomKey)

    mandatoryArrayString = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayStringKey")
    mandatoryArrayInt = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayIntKey")
    mandatoryArrayDouble = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayDoubleKey")
    mandatoryArrayBool = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayBoolKey")
    mandatoryWeakDictionaryArrayKey = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")
    mandatoryArrayCustomJSONObject = try jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")

    optionalExistingArrayString = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayStringKey")
    optionalExistingArrayInt = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayIntKey")
    optionalExistingArrayDouble = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayDoubleKey")
    optionalExistingArrayBool = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayBoolKey")
    optionalExistingWeakDictionaryArrayKey = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")
    optionalExistingArrayCustomJSONObject = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryArrayCustomJSONObjectKey")

    optionalMissingArrayString = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayInt = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayDouble = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayBool = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingWeakDictionaryArrayKey = try? jsonDictionary.json(atKeyPath: randomKey)
    optionalMissingArrayCustomJSONObject = try? jsonDictionary.json(atKeyPath: randomKey)

    mandatoryIntDictionary = try jsonDictionary.json(atKeyPath: "keypath.mandatoryIntDictionary")
    mandatoryObjectDictionary = try jsonDictionary.json(atKeyPath: "keypath.mandatoryObjectDictionary")
    mandatoryURLDictionary = try jsonDictionary.json(atKeyPath: "keypath.mandatoryURLDictionary")

    optionalIntDictionary = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryIntDictionary")
    optionalObjectDictionary = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryObjectDictionary")
    optionalURLDictionary = try? jsonDictionary.json(atKeyPath: "keypath.mandatoryURLDictionary")
  }
}
