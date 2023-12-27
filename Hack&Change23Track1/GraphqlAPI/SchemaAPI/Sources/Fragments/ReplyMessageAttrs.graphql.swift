// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ReplyMessageAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ReplyMessageAttrs on ReplyMessage { __typename From { __typename ...MessageUserAttrs } Id Text Type }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReplyMessage }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("From", From?.self),
    .field("Id", String?.self),
    .field("Text", String?.self),
    .field("Type", GraphQLEnum<SchemaAPI.MessageType>?.self),
  ] }

  public var from: From? { __data["From"] }
  public var id: String? { __data["Id"] }
  public var text: String? { __data["Text"] }
  public var type: GraphQLEnum<SchemaAPI.MessageType>? { __data["Type"] }

  public init(
    from: From? = nil,
    id: String? = nil,
    text: String? = nil,
    type: GraphQLEnum<SchemaAPI.MessageType>? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.ReplyMessage.typename,
        "From": from._fieldData,
        "Id": id,
        "Text": text,
        "Type": type,
      ],
      fulfilledFragments: [
        ObjectIdentifier(ReplyMessageAttrs.self)
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
          ObjectIdentifier(ReplyMessageAttrs.From.self),
          ObjectIdentifier(MessageUserAttrs.self)
        ]
      ))
    }
  }
}
