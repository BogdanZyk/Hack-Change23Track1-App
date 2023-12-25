// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ReplyMessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    type: GraphQLNullable<GraphQLEnum<MessageType>> = nil,
    text: GraphQLNullable<String> = nil,
    userName: GraphQLNullable<String> = nil,
    id: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "Type": type,
      "Text": text,
      "UserName": userName,
      "Id": id
    ])
  }

  public var type: GraphQLNullable<GraphQLEnum<MessageType>> {
    get { __data["Type"] }
    set { __data["Type"] = newValue }
  }

  public var text: GraphQLNullable<String> {
    get { __data["Text"] }
    set { __data["Text"] = newValue }
  }

  public var userName: GraphQLNullable<String> {
    get { __data["UserName"] }
    set { __data["UserName"] = newValue }
  }

  public var id: GraphQLNullable<String> {
    get { __data["Id"] }
    set { __data["Id"] = newValue }
  }
}
