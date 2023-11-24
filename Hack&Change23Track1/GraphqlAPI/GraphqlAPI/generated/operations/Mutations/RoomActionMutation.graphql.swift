// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
import Hack&Change23Track1&

class RoomActionMutation: GraphQLMutation {
  static let operationName: String = "RoomAction"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RoomAction($roomId: String!, $action: String!, $arg: String!) { RoomAction(RoomId: $roomId, Action: $action, Arg: $arg) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, PlayerItemAttrs.self, FileAttrs.self, UserAttrs.self]
    ))

  public var roomId: String
  public var action: String
  public var arg: String

  public init(
    roomId: String,
    action: String,
    arg: String
  ) {
    self.roomId = roomId
    self.action = action
    self.arg = arg
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "action": action,
    "arg": arg
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("RoomAction", RoomAction?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Action": .variable("action"),
        "Arg": .variable("arg")
      ]),
    ] }

    var roomAction: RoomAction? { __data["RoomAction"] }

    init(
      roomAction: RoomAction? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "RoomAction": roomAction._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(RoomActionMutation.Data.self)
        ]
      ))
    }

    /// RoomAction
    ///
    /// Parent Type: `Room`
    struct RoomAction: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Room }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(RoomAttrs.self),
      ] }

      var file: File? { __data["File"] }
      var id: String? { __data["Id"] }
      var likes: Int? { __data["Likes"] }
      var name: String? { __data["Name"] }
      var members: [Member?]? { __data["Members"] }
      var owner: RoomAttrs.Owner? { __data["Owner"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var roomAttrs: RoomAttrs { _toFragment() }
      }

      init(
        file: File? = nil,
        id: String? = nil,
        likes: Int? = nil,
        name: String? = nil,
        members: [Member?]? = nil,
        owner: RoomAttrs.Owner? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "File": file._fieldData,
            "Id": id,
            "Likes": likes,
            "Name": name,
            "Members": members._fieldData,
            "Owner": owner._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(RoomActionMutation.Data.RoomAction.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// RoomAction.File
      ///
      /// Parent Type: `PlayFile`
      struct File: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlayFile }

        var currentSeconds: String? { __data["CurrentSeconds"] }
        var durationSeconds: String? { __data["DurationSeconds"] }
        var file: File? { __data["File"] }
        var pause: Bool? { __data["Pause"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var playerItemAttrs: PlayerItemAttrs { _toFragment() }
        }

        init(
          currentSeconds: String? = nil,
          durationSeconds: String? = nil,
          file: File? = nil,
          pause: Bool? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.PlayFile.typename,
              "CurrentSeconds": currentSeconds,
              "DurationSeconds": durationSeconds,
              "File": file._fieldData,
              "Pause": pause,
            ],
            fulfilledFragments: [
              ObjectIdentifier(RoomActionMutation.Data.RoomAction.File.self),
              ObjectIdentifier(PlayerItemAttrs.self),
              ObjectIdentifier(RoomAttrs.File.self)
            ]
          ))
        }

        /// RoomAction.File.File
        ///
        /// Parent Type: `Audio`
        struct File: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }

          var id: String? { __data["Id"] }
          var name: String? { __data["Name"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var fileAttrs: FileAttrs { _toFragment() }
          }

          init(
            id: String? = nil,
            name: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Audio.typename,
                "Id": id,
                "Name": name,
              ],
              fulfilledFragments: [
                ObjectIdentifier(RoomActionMutation.Data.RoomAction.File.File.self),
                ObjectIdentifier(FileAttrs.self),
                ObjectIdentifier(PlayerItemAttrs.File.self)
              ]
            ))
          }
        }
      }

      /// RoomAction.Member
      ///
      /// Parent Type: `User`
      struct Member: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.User }

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
              ObjectIdentifier(RoomActionMutation.Data.RoomAction.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
