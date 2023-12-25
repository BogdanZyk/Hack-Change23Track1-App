// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateCurrentUserMutation: GraphQLMutation {
  public static let operationName: String = "UpdateCurrentUser"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCurrentUser($avatar: String) { UpdateCurrentUser(Avatar: $avatar) { __typename ...UserAttrs } }"#,
      fragments: [UserAttrs.self]
    ))

  public var avatar: GraphQLNullable<String>

  public init(avatar: GraphQLNullable<String>) {
    self.avatar = avatar
  }

  public var __variables: Variables? { ["avatar": avatar] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("UpdateCurrentUser", UpdateCurrentUser?.self, arguments: ["Avatar": .variable("avatar")]),
    ] }

    public var updateCurrentUser: UpdateCurrentUser? { __data["UpdateCurrentUser"] }

    public init(
      updateCurrentUser: UpdateCurrentUser? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "UpdateCurrentUser": updateCurrentUser._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(UpdateCurrentUserMutation.Data.self)
        ]
      ))
    }

    /// UpdateCurrentUser
    ///
    /// Parent Type: `User`
    public struct UpdateCurrentUser: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(UserAttrs.self),
      ] }

      public var id: String? { __data["Id"] }
      public var login: String? { __data["Login"] }
      public var avatar: String? { __data["Avatar"] }
      public var email: String? { __data["Email"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var userAttrs: UserAttrs { _toFragment() }
      }

      public init(
        id: String? = nil,
        login: String? = nil,
        avatar: String? = nil,
        email: String? = nil
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
            ObjectIdentifier(UpdateCurrentUserMutation.Data.UpdateCurrentUser.self),
            ObjectIdentifier(UserAttrs.self)
          ]
        ))
      }
    }
  }
}
