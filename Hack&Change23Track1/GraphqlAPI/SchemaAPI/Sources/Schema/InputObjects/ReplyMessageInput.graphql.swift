// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ReplyMessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    id: GraphQLNullable<String> = nil,
    text: GraphQLNullable<String> = nil,
    userName: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "Id": id,
      "Text": text,
      "UserName": userName
    ])
  }

  public var id: GraphQLNullable<String> {
    get { __data["Id"] }
    set { __data["Id"] = newValue }
  }

  public var text: GraphQLNullable<String> {
    get { __data["Text"] }
    set { __data["Text"] = newValue }
  }

  public var userName: GraphQLNullable<String> {
    get { __data["UserName"] }
    set { __data["UserName"] = newValue }
  }
}
