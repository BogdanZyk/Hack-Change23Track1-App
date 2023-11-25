// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct UserAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment UserAttrs on User { __typename Id Login Avatar Email }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String.self),
    .field("Login", String.self),
    .field("Avatar", String.self),
    .field("Email", String.self),
  ] }

  var id: String { __data["Id"] }
  var login: String { __data["Login"] }
  var avatar: String { __data["Avatar"] }
  var email: String { __data["Email"] }

  init(
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
