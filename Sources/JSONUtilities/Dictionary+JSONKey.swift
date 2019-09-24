//
//  Dictionary+JSONKey.swift
//  JSONUtilities
//
//  Created by Luciano Marisi on 05/03/2016.
//  Copyright © 2016 Luciano Marisi All rights reserved.
//

import Foundation

/// Protocol used for defining the valid JSON types, i.e. Int, Double, Float, String and Bool
public protocol JSONRawType {}
extension Int : JSONRawType {}
extension Double : JSONRawType {}
extension Float : JSONRawType {}
extension String : JSONRawType {}
extension Bool : JSONRawType {}

// Simple protocol used to extend a JSONDictionary
public protocol StringProtocol {
  func components(separatedBy: String) -> [String]
  var string: String { get }
}
extension String: StringProtocol {
  public var string: String {
    return self
  }
}

extension Dictionary where Key: StringProtocol {

  // MARK: JSONRawType type

  /// Decode a mandatory JSON raw type
  public func json<T: JSONRawType>(atKeyPath keyPath: Key) throws -> T {
    return try getValue(atKeyPath: keyPath)
  }

  // MARK: [JSONRawType] type

  /// Decode an Array of mandatory JSON raw types
  public func json<T: JSONRawType>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [T] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour, decode: getValue)
  }

  // MARK: [String: Any] type

  /// Decodes as a raw Dictionary with a mandatory key
  public func json(atKeyPath keyPath: Key) throws -> JSONDictionary {
    return try getValue(atKeyPath: keyPath)
  }

  // MARK: [[String: Any]] type

  /// Decodes as a raw dictionary array with a mandatory key
  public func json(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<JSONDictionary> = .remove) throws -> [JSONDictionary] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour, decode: getValue)
  }

  // MARK: [String: JSONObjectConvertible] type

  /// Decodes a mandatory dictionary
  public func json<T: JSONObjectConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [String: T] {
    return try decodeDictionary(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { jsonDictionary, key in
      return try jsonDictionary.json(atKeyPath: key) as T
    }
  }

  // MARK: [String: JSONRawType] type

  /// Decodes a mandatory dictionary
  public func json<T: JSONRawType>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [String: T] {
    return try decodeDictionary(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { jsonDictionary, key in
      return try jsonDictionary.json(atKeyPath: key) as T
    }
  }

  // MARK: [String: JSONPrimitiveConvertible] type

  /// Decodes a mandatory dictionary
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [String: T] {
    return try decodeDictionary(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { jsonDictionary, key in
      return try jsonDictionary.json(atKeyPath: key) as T
    }
  }

  // MARK: Decodable types

  /// Decode a mandatory Decodable object
  public func json<T: JSONObjectConvertible>(atKeyPath keyPath: Key) throws -> T {
    return try T(jsonDictionary: JSONDictionaryForKey(atKeyPath: keyPath))
  }

  // MARK: [Decodable] types

  /// Decode an Array of mandatory Decodable objects
  public func json<T: JSONObjectConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [T] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { keyPath, jsonArray, value in
      let jsonDictionary: JSONDictionary = try getValue(atKeyPath: keyPath, array: jsonArray, value: value)
      return try T(jsonDictionary: jsonDictionary)
    }
  }

  // MARK: RawRepresentable type

  /// Decode a mandatory RawRepresentable
  public func json<T: RawRepresentable>(atKeyPath keyPath: Key) throws -> T where T.RawValue:JSONRawType {
    let rawValue: T.RawValue = try getValue(atKeyPath: keyPath)

    guard let value = T(rawValue:rawValue) else {
      throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: T.self, value: rawValue, reason: .incorrectRawRepresentableRawValue)
    }

    return value
  }

  // MARK: [RawRepresentable] type

  /// Decode an array of custom RawRepresentable types with a mandatory key
  public func json<T: RawRepresentable>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [T] where T.RawValue:JSONRawType {

    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { keyPath, jsonArray, value in
      let rawValue: T.RawValue = try getValue(atKeyPath: keyPath, array: jsonArray, value: value)

      guard let value = T(rawValue:rawValue) else {
        throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: T.self, value: rawValue, array: jsonArray, reason: .incorrectRawRepresentableRawValue)
      }
      return value
    }
  }

  // MARK: [String: RawRepresentable] type

  /// Decode a dictionary of custom RawRepresentable types with a mandatory key
  public func json<T: RawRepresentable>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [String: T] where T.RawValue:JSONRawType {
    return try decodeDictionary(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { jsonDictionary, key in
      let rawValue: T.RawValue = try jsonDictionary.getValue(atKeyPath: key)

      guard let value = T(rawValue:rawValue) else {
        throw DecodingError(dictionary: jsonDictionary, keyPath: keyPath, expectedType: T.self, value: rawValue, reason: .incorrectRawRepresentableRawValue)
      }
      return value
    }
  }

  // MARK: JSONPrimitiveConvertible type

  /// Decode a custom raw types with a mandatory key
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key) throws -> T {
    let jsonValue: T.JSONType = try getValue(atKeyPath: keyPath)

    guard let transformedValue = T.from(jsonValue: jsonValue) else {
      throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: T.self, value: jsonValue, reason: .conversionFailure)
    }

    return transformedValue
  }

  // MARK: [JSONPrimitiveConvertible] type

  /// Decode an array of custom raw types with a mandatory key
  public func json<T: JSONPrimitiveConvertible>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove) throws -> [T] {
    return try decodeArray(atKeyPath: keyPath, invalidItemBehaviour: invalidItemBehaviour) { keyPath, jsonArray, value in
      let jsonValue: T.JSONType = try getValue(atKeyPath: keyPath, array: jsonArray, value: value)

      guard let transformedValue = T.from(jsonValue: jsonValue) else {
        throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: T.self, value: jsonValue, array: jsonArray, reason: .conversionFailure)
      }
      return transformedValue
    }
  }

  // MARK: JSONDictionary and JSONArray creation

  fileprivate func JSONDictionaryForKey(atKeyPath keyPath: Key) throws -> JSONDictionary {
    return try getValue(atKeyPath: keyPath)
  }

  fileprivate func JSONArrayForKey(atKeyPath keyPath: Key) throws -> JSONArray {
    return try getValue(atKeyPath: keyPath)
  }

  // MARK: Value decoding

  fileprivate func getValue<A, B>(atKeyPath keyPath: Key, array: [A], value: A) throws -> B {
    guard let typedValue = value as? B else {
      throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: B.self, value: value, array: array, reason: .incorrectType)
    }
    return typedValue
  }

  fileprivate func getValue<T>(atKeyPath keyPath: Key) throws -> T {
    guard let value = self[keyPath: keyPath] else {
      throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: T.self, value: "", reason: .keyNotFound)
    }
    guard let typedValue = value as? T else {
      throw DecodingError(dictionary: self, keyPath: keyPath, expectedType: T.self, value: value, reason: .incorrectType)
    }
    return typedValue
  }

  // MARK: Dictionary decoding

  fileprivate func decodeDictionary<T>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove, decode: (JSONDictionary, String) throws -> T) throws -> [String: T] {
    let jsonDictionary: JSONDictionary = try json(atKeyPath: keyPath)

    var dictionary: [String: T] = [:]
    for (key, _) in jsonDictionary {
      if let item = try invalidItemBehaviour.decodeItem(decode: { try decode(jsonDictionary, key) }) {
          dictionary[key] = item
      }
    }

    return dictionary
  }

  // MARK: Array decoding

  fileprivate func decodeArray<T>(atKeyPath keyPath: Key, invalidItemBehaviour: InvalidItemBehaviour<T> = .remove, decode: (Key, JSONArray, Any) throws -> T) throws -> [T] {
    let jsonArray = try JSONArrayForKey(atKeyPath: keyPath)
    return try jsonArray.compactMap { value in
      try invalidItemBehaviour.decodeItem(decode: { try decode(keyPath, jsonArray, value) })
    }
  }

}
