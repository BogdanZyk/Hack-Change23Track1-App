// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MessageUserAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MessageUserAttrs on User { __typename Avatar Id Login }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Avatar", String.self),
    .field("Id", String.self),
    .field("Login", String.self),
  ] }

  public var avatar: String { __data["Avatar"] }
  public var id: String { __data["Id"] }
  public var login: String { __data["Login"] }

  public init(
    avatar: String,
    id: String,
    login: String
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.User.typename,
        "Avatar": avatar,
        "Id": id,
        "Login": login,
      ],
      fulfilledFragments: [
        ObjectIdentifier(MessageUserAttrs.self)
      ]
    ))
  }
}
