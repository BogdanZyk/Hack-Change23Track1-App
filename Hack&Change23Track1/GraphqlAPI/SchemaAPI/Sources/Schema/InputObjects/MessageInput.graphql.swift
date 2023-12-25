// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct MessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    type: GraphQLNullable<GraphQLEnum<MessageType>> = nil,
    text: GraphQLNullable<String> = nil,
    replyMessage: GraphQLNullable<ReplyMessageInput> = nil
  ) {
    __data = InputDict([
      "Type": type,
      "Text": text,
      "ReplyMessage": replyMessage
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

  public var replyMessage: GraphQLNullable<ReplyMessageInput> {
    get { __data["ReplyMessage"] }
    set { __data["ReplyMessage"] = newValue }
  }
}
