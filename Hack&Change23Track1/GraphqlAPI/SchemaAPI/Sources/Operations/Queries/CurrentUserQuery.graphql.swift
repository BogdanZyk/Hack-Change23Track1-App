// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CurrentUserQuery: GraphQLQuery {
  public static let operationName: String = "CurrentUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CurrentUser { CurrentUser { __typename ...UserAttrs } }"#,
      fragments: [UserAttrs.self]
    ))

  public init() {}

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("CurrentUser", CurrentUser?.self),
    ] }

    public var currentUser: CurrentUser? { __data["CurrentUser"] }

    public init(
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
    public struct CurrentUser: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(UserAttrs.self),
      ] }

      public var id: String { __data["Id"] }
      public var login: String { __data["Login"] }
      public var avatar: String { __data["Avatar"] }
      public var email: String { __data["Email"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var userAttrs: UserAttrs { _toFragment() }
      }

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
            ObjectIdentifier(CurrentUserQuery.Data.CurrentUser.self),
            ObjectIdentifier(UserAttrs.self)
          ]
        ))
      }
    }
  }
}
