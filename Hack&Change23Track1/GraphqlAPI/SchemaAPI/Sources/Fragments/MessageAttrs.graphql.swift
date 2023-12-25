// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MessageAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MessageAttrs on Message { __typename From { __typename ...MessageUserAttrs } Id Reactions { __typename ...ReactionMessageAttrs } ReplyMessage { __typename ...ReplyMessageAttrs } Text Type }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Message }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("From", From?.self),
    .field("Id", String?.self),
    .field("Reactions", [Reaction?]?.self),
    .field("ReplyMessage", ReplyMessage?.self),
    .field("Text", String?.self),
    .field("Type", GraphQLEnum<SchemaAPI.MessageType>?.self),
  ] }

  public var from: From? { __data["From"] }
  public var id: String? { __data["Id"] }
  public var reactions: [Reaction?]? { __data["Reactions"] }
  public var replyMessage: ReplyMessage? { __data["ReplyMessage"] }
  public var text: String? { __data["Text"] }
  public var type: GraphQLEnum<SchemaAPI.MessageType>? { __data["Type"] }

  public init(
    from: From? = nil,
    id: String? = nil,
    reactions: [Reaction?]? = nil,
    replyMessage: ReplyMessage? = nil,
    text: String? = nil,
    type: GraphQLEnum<SchemaAPI.MessageType>? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.Message.typename,
        "From": from._fieldData,
        "Id": id,
        "Reactions": reactions._fieldData,
        "ReplyMessage": replyMessage._fieldData,
        "Text": text,
        "Type": type,
      ],
      fulfilledFragments: [
        ObjectIdentifier(MessageAttrs.self)
      ]
    ))
  }

  /// From
  ///
  /// Parent Type: `User`
  public struct From: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(MessageUserAttrs.self),
    ] }

    public var avatar: String? { __data["Avatar"] }
    public var id: String? { __data["Id"] }
    public var login: String? { __data["Login"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var messageUserAttrs: MessageUserAttrs { _toFragment() }
    }

    public init(
      avatar: String? = nil,
      id: String? = nil,
      login: String? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.User.typename,
          "Avatar": avatar,
          "Id": id,
          "Login": login,
        ],
        fulfilledFragments: [
          ObjectIdentifier(MessageAttrs.From.self),
          ObjectIdentifier(MessageUserAttrs.self)
        ]
      ))
    }
  }

  /// Reaction
  ///
  /// Parent Type: `ReactionMessage`
  public struct Reaction: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReactionMessage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(ReactionMessageAttrs.self),
    ] }

    public var reaction: String? { __data["Reaction"] }
    public var from: ReactionMessageAttrs.From? { __data["From"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var reactionMessageAttrs: ReactionMessageAttrs { _toFragment() }
    }

    public init(
      reaction: String? = nil,
      from: ReactionMessageAttrs.From? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.ReactionMessage.typename,
          "Reaction": reaction,
          "From": from._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(MessageAttrs.Reaction.self),
          ObjectIdentifier(ReactionMessageAttrs.self)
        ]
      ))
    }
  }

  /// ReplyMessage
  ///
  /// Parent Type: `ReplyMessage`
  public struct ReplyMessage: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReplyMessage }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(ReplyMessageAttrs.self),
    ] }

    public var id: String? { __data["Id"] }
    public var text: String? { __data["Text"] }
    public var userName: String? { __data["UserName"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var replyMessageAttrs: ReplyMessageAttrs { _toFragment() }
    }

    public init(
      id: String? = nil,
      text: String? = nil,
      userName: String? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.ReplyMessage.typename,
          "Id": id,
          "Text": text,
          "UserName": userName,
        ],
        fulfilledFragments: [
          ObjectIdentifier(MessageAttrs.ReplyMessage.self),
          ObjectIdentifier(ReplyMessageAttrs.self)
        ]
      ))
    }
  }
}
