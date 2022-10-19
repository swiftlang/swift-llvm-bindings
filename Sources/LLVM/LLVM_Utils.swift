//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

@_exported import LLVM_Utils // Clang module

extension String {
  public init(_ stringRef: llvm.StringRef) {
    self.init(cxxString: stringRef.str())
  }

  public func withStringRef<Result>(_ body: (llvm.StringRef) -> Result) -> Result {
    var str = self
    return str.withUTF8 { buffer in
      return body(llvm.StringRef(buffer.baseAddress, buffer.count))
    }
  }
}

extension StaticString {
  public func withStringRef<Result>(_ body: (llvm.StringRef) -> Result) -> Result {
    return self.withUTF8Buffer { buffer in
      return body(llvm.StringRef(buffer.baseAddress, buffer.count))
    }
  }
}

public func ==(lhs: llvm.StringRef, rhs: StaticString) -> Bool {
  let lhsBuffer = UnsafeBufferPointer<UInt8>(
    start: lhs.__bytes_beginUnsafe(),
    count: Int(lhs.__bytes_endUnsafe() - lhs.__bytes_beginUnsafe()))
  return rhs.withUTF8Buffer { (rhsBuffer: UnsafeBufferPointer<UInt8>) in
    if lhsBuffer.count != rhsBuffer.count { return false }
    return lhsBuffer.elementsEqual(rhsBuffer, by: ==)
  }
}

extension llvm.Twine: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}
