// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1

class UpdateCurrentUserMutation: GraphQLMutation {
  static let operationName: String = "UpdateCurrentUser"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateCurrentUser($avatar: String) { UpdateCurrentUser(Avatar: $avatar) { __typename ...UserAttrs } }"#,
      fragments: [UserAttrs.self]
    ))

  public var avatar: GraphQLNullable<String>

  public init(avatar: GraphQLNullable<String>) {
    self.avatar = avatar
  }

  public var __variables: Variables? { ["avatar": avatar] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("UpdateCurrentUser", UpdateCurrentUser?.self, arguments: ["Avatar": .variable("avatar")]),
    ] }

    var updateCurrentUser: UpdateCurrentUser? { __data["UpdateCurrentUser"] }

    init(
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
    struct UpdateCurrentUser: SchemaAPI.SelectionSet {
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

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var userAttrs: UserAttrs { _toFragment() }
      }

      init(
        id: String,
        login: String,
        avatar: String
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.User.typename,
            "Id": id,
            "Login": login,
            "Avatar": avatar,
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
