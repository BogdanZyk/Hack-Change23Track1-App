// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI


class LoadAudioMutation: GraphQLMutation {
  static let operationName: String = "LoadAudio"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation LoadAudio($roomId: String!, $audioId: String!) { LoadAudio(RoomId: $roomId, AudioId: $audioId) { __typename ...RoomAttrs } }"#,
      fragments: [RoomAttrs.self, PlayerItemAttrs.self, FileAttrs.self, UserAttrs.self]
    ))

  public var roomId: String
  public var audioId: String

  public init(
    roomId: String,
    audioId: String
  ) {
    self.roomId = roomId
    self.audioId = audioId
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "audioId": audioId
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("LoadAudio", LoadAudio?.self, arguments: [
        "RoomId": .variable("roomId"),
        "AudioId": .variable("audioId")
      ]),
    ] }

    var loadAudio: LoadAudio? { __data["LoadAudio"] }

    init(
      loadAudio: LoadAudio? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "LoadAudio": loadAudio._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(LoadAudioMutation.Data.self)
        ]
      ))
    }

    /// LoadAudio
    ///
    /// Parent Type: `Room`
    struct LoadAudio: SchemaAPI.SelectionSet {
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
        file: File? = nil,
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
            "File": file._fieldData,
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
            ObjectIdentifier(LoadAudioMutation.Data.LoadAudio.self),
            ObjectIdentifier(RoomAttrs.self)
          ]
        ))
      }

      /// LoadAudio.File
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
              ObjectIdentifier(LoadAudioMutation.Data.LoadAudio.File.self),
              ObjectIdentifier(PlayerItemAttrs.self),
              ObjectIdentifier(RoomAttrs.File.self)
            ]
          ))
        }

        /// LoadAudio.File.File
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
                ObjectIdentifier(LoadAudioMutation.Data.LoadAudio.File.File.self),
                ObjectIdentifier(FileAttrs.self),
                ObjectIdentifier(PlayerItemAttrs.File.self)
              ]
            ))
          }
        }
      }

      /// LoadAudio.Member
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
              ObjectIdentifier(LoadAudioMutation.Data.LoadAudio.Member.self),
              ObjectIdentifier(UserAttrs.self),
              ObjectIdentifier(RoomAttrs.Member.self)
            ]
          ))
        }
      }
    }
  }
}
