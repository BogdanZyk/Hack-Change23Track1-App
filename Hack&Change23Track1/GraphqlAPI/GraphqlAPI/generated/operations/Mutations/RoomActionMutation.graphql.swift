// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class RoomActionMutation: GraphQLMutation {
  static let operationName: String = "RoomAction"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RoomAction($roomId: String!, $action: String!, $arg: String!) { RoomAction(RoomId: $roomId, Action: $action, Arg: $arg) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, MediaInfoAttrs.self, SourceAttrs.self, UserAttrs.self]
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

      var mediaInfo: MediaInfo? { __data["MediaInfo"] }
      var id: String? { __data["Id"] }
      var likes: Int? { __data["Likes"] }
      var `private`: Bool? { __data["Private"] }
      var image: String? { __data["Image"] }
      var key: String? { __data["Key"] }
      var name: String? { __data["Name"] }
      var members: [Member?]? { __data["Members"] }
      var owner: RoomAttrs.Owner? { __data["Owner"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var roomAttrs: RoomAttrs { _toFragment() }
      }

      init(
        mediaInfo: MediaInfo? = nil,
        id: String? = nil,
        likes: Int? = nil,
        `private`: Bool? = nil,
        image: String? = nil,
        key: String? = nil,
        name: String? = nil,
        members: [Member?]? = nil,
        owner: RoomAttrs.Owner? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Room.typename,
            "MediaInfo": mediaInfo._fieldData,
            "Id": id,
            "Likes": likes,
            "Private": `private`,
            "Image": image,
            "Key": key,
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

      /// RoomAction.MediaInfo
      ///
      /// Parent Type: `MediaInfo`
      struct MediaInfo: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }

        var currentSeconds: String? { __data["CurrentSeconds"] }
        var pause: Bool? { __data["Pause"] }
        var source: Source? { __data["Source"] }
        var url: String? { __data["Url"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var mediaInfoAttrs: MediaInfoAttrs { _toFragment() }
        }

        init(
          currentSeconds: String? = nil,
          pause: Bool? = nil,
          source: Source? = nil,
          url: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.MediaInfo.typename,
              "CurrentSeconds": currentSeconds,
              "Pause": pause,
              "Source": source._fieldData,
              "Url": url,
            ],
            fulfilledFragments: [
              ObjectIdentifier(RoomActionMutation.Data.RoomAction.MediaInfo.self),
              ObjectIdentifier(MediaInfoAttrs.self),
              ObjectIdentifier(RoomAttrs.MediaInfo.self)
            ]
          ))
        }

        /// RoomAction.MediaInfo.Source
        ///
        /// Parent Type: `Source`
        struct Source: SchemaAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

          var name: String? { __data["Name"] }
          var id: String? { __data["Id"] }
          var cover: String? { __data["Cover"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var sourceAttrs: SourceAttrs { _toFragment() }
          }

          init(
            name: String? = nil,
            id: String? = nil,
            cover: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": SchemaAPI.Objects.Source.typename,
                "Name": name,
                "Id": id,
                "Cover": cover,
              ],
              fulfilledFragments: [
                ObjectIdentifier(RoomActionMutation.Data.RoomAction.MediaInfo.Source.self),
                ObjectIdentifier(SourceAttrs.self),
                ObjectIdentifier(MediaInfoAttrs.Source.self)
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
