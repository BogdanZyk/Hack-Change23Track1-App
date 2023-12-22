// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct ReactionMessageAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ReactionMessageAttrs on ReactionMessage { __typename Reaction From { __typename Id } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.ReactionMessage }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Reaction", String?.self),
    .field("From", From?.self),
  ] }

  public var reaction: String? { __data["Reaction"] }
  public var from: From? { __data["From"] }

  public init(
    reaction: String? = nil,
    from: From? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.ReactionMessage.typename,
        "Reaction": reaction,
        "From": from._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(ReactionMessageAttrs.self)
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
      .field("Id", String.self),
    ] }

    public var id: String { __data["Id"] }

    public init(
      id: String
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.User.typename,
          "Id": id,
        ],
        fulfilledFragments: [
          ObjectIdentifier(ReactionMessageAttrs.From.self)
        ]
      ))
    }
  }
}
