// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI


class CurrentUserQuery: GraphQLQuery {
  static let operationName: String = "CurrentUser"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CurrentUser { CurrentUser { __typename ...UserAttrs } }"#,
      fragments: [UserAttrs.self]
    ))

  public init() {}

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("CurrentUser", CurrentUser?.self),
    ] }

    var currentUser: CurrentUser? { __data["CurrentUser"] }

    init(
      currentUser: CurrentUser? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "CurrentUser": currentUser._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(CurrentUserQuery.Data.self)
        ]
      ))
    }

    /// CurrentUser
    ///
    /// Parent Type: `User`
    struct CurrentUser: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(UserAttrs.self),
      ] }

      var id: String { __data["Id"] }
      var login: String { __data["Login"] }
      var avatar: String { __data["Avatar"] }
      var email: String { __data["Email"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var userAttrs: UserAttrs { _toFragment() }
      }

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
            ObjectIdentifier(CurrentUserQuery.Data.CurrentUser.self),
            ObjectIdentifier(UserAttrs.self)
          ]
        ))
      }
    }
  }
}
