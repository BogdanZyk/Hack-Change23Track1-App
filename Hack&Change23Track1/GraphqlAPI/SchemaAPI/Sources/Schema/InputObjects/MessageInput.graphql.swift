// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct MessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    text: GraphQLNullable<String> = nil,
    replyMessage: GraphQLNullable<String> = nil,
    type: GraphQLNullable<GraphQLEnum<MessageType>> = nil
  ) {
    __data = InputDict([
      "Text": text,
      "ReplyMessage": replyMessage,
      "Type": type
    ])
  }

  public var text: GraphQLNullable<String> {
    get { __data["Text"] }
    set { __data["Text"] = newValue }
  }

  public var replyMessage: GraphQLNullable<String> {
    get { __data["ReplyMessage"] }
    set { __data["ReplyMessage"] = newValue }
  }

  public var type: GraphQLNullable<GraphQLEnum<MessageType>> {
    get { __data["Type"] }
    set { __data["Type"] = newValue }
  }
}
