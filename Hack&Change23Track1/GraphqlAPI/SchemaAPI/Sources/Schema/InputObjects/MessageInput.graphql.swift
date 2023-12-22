// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct MessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    replyMessage: GraphQLNullable<ReplyMessageInput> = nil,
    reactions: GraphQLNullable<[ReactionMessageInput?]> = nil,
    sticker: GraphQLNullable<Int> = nil,
    id: GraphQLNullable<String> = nil,
    from: GraphQLNullable<UserInput> = nil,
    type: GraphQLNullable<GraphQLEnum<MessageType>> = nil,
    text: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "ReplyMessage": replyMessage,
      "Reactions": reactions,
      "Sticker": sticker,
      "Id": id,
      "From": from,
      "Type": type,
      "Text": text
    ])
  }

  public var replyMessage: GraphQLNullable<ReplyMessageInput> {
    get { __data["ReplyMessage"] }
    set { __data["ReplyMessage"] = newValue }
  }

  public var reactions: GraphQLNullable<[ReactionMessageInput?]> {
    get { __data["Reactions"] }
    set { __data["Reactions"] = newValue }
  }

  public var sticker: GraphQLNullable<Int> {
    get { __data["Sticker"] }
    set { __data["Sticker"] = newValue }
  }

  public var id: GraphQLNullable<String> {
    get { __data["Id"] }
    set { __data["Id"] = newValue }
  }

  public var from: GraphQLNullable<UserInput> {
    get { __data["From"] }
    set { __data["From"] = newValue }
  }

  public var type: GraphQLNullable<GraphQLEnum<MessageType>> {
    get { __data["Type"] }
    set { __data["Type"] = newValue }
  }

  public var text: GraphQLNullable<String> {
    get { __data["Text"] }
    set { __data["Text"] = newValue }
  }
}
