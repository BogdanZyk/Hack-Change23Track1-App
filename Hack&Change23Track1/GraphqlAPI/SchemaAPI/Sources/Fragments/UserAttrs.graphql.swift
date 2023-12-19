// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct UserAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment UserAttrs on User { __typename Id Login Avatar Email }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String.self),
    .field("Login", String.self),
    .field("Avatar", String.self),
    .field("Email", String.self),
  ] }

  public var id: String { __data["Id"] }
  public var login: String { __data["Login"] }
  public var avatar: String { __data["Avatar"] }
  public var email: String { __data["Email"] }

  public init(
    id: String,
    login: String,
    avatar: String,
    email: String
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.User.typename,
        "Id": id,
        "Login": login,
        "Avatar": avatar,
        "Email": email,
      ],
      fulfilledFragments: [
        ObjectIdentifier(UserAttrs.self)
      ]
    ))
  }
}
