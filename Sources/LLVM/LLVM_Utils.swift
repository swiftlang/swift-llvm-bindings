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
