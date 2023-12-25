// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SubscribeMediaInfoSubscription: GraphQLSubscription {
  public static let operationName: String = "SubscribeMediaInfo"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"subscription SubscribeMediaInfo($roomId: String) { SubscribeMediaInfo(RoomId: $roomId) { __typename CurrentTimeSeconds DurationSeconds MediaAction Source { __typename ...SourceAttrs } } }"#,
      fragments: [SourceAttrs.self]
    ))

  public var roomId: GraphQLNullable<String>

  public init(roomId: GraphQLNullable<String>) {
    self.roomId = roomId
  }

  public var __variables: Variables? { ["roomId": roomId] }

  public struct Data: SchemaAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootSubscriptionType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("SubscribeMediaInfo", SubscribeMediaInfo?.self, arguments: ["RoomId": .variable("roomId")]),
    ] }

    public var subscribeMediaInfo: SubscribeMediaInfo? { __data["SubscribeMediaInfo"] }

    public init(
      subscribeMediaInfo: SubscribeMediaInfo? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootSubscriptionType.typename,
          "SubscribeMediaInfo": subscribeMediaInfo._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(SubscribeMediaInfoSubscription.Data.self)
        ]
      ))
    }

    /// SubscribeMediaInfo
    ///
    /// Parent Type: `MediaInfo`
    public struct SubscribeMediaInfo: SchemaAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("CurrentTimeSeconds", Double?.self),
        .field("DurationSeconds", Double?.self),
        .field("MediaAction", GraphQLEnum<SchemaAPI.MediaAction>?.self),
        .field("Source", Source?.self),
      ] }

      public var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
      public var durationSeconds: Double? { __data["DurationSeconds"] }
      public var mediaAction: GraphQLEnum<SchemaAPI.MediaAction>? { __data["MediaAction"] }
      public var source: Source? { __data["Source"] }

      public init(
        currentTimeSeconds: Double? = nil,
        durationSeconds: Double? = nil,
        mediaAction: GraphQLEnum<SchemaAPI.MediaAction>? = nil,
        source: Source? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.MediaInfo.typename,
            "CurrentTimeSeconds": currentTimeSeconds,
            "DurationSeconds": durationSeconds,
            "MediaAction": mediaAction,
            "Source": source._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(SubscribeMediaInfoSubscription.Data.SubscribeMediaInfo.self)
          ]
        ))
      }

      /// SubscribeMediaInfo.Source
      ///
      /// Parent Type: `Source`
      public struct Source: SchemaAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .fragment(SourceAttrs.self),
        ] }

        public var id: String? { __data["Id"] }
        public var cover: String? { __data["Cover"] }
        public var name: String? { __data["Name"] }
        public var url: String? { __data["Url"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var sourceAttrs: SourceAttrs { _toFragment() }
        }

        public init(
          id: String? = nil,
          cover: String? = nil,
          name: String? = nil,
          url: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.Source.typename,
              "Id": id,
              "Cover": cover,
              "Name": name,
              "Url": url,
            ],
            fulfilledFragments: [
              ObjectIdentifier(SubscribeMediaInfoSubscription.Data.SubscribeMediaInfo.Source.self),
              ObjectIdentifier(SourceAttrs.self)
            ]
          ))
        }
      }
    }
  }
}
