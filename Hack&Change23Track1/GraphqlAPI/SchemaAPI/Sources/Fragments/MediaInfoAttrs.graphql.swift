// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct MediaInfoAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment MediaInfoAttrs on MediaInfo { __typename CurrentTimeSeconds DurationSeconds Source { __typename ...SourceAttrs } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("CurrentTimeSeconds", Double?.self),
    .field("DurationSeconds", Double?.self),
    .field("Source", Source?.self),
  ] }

  public var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
  public var durationSeconds: Double? { __data["DurationSeconds"] }
  public var source: Source? { __data["Source"] }

  public init(
    currentTimeSeconds: Double? = nil,
    durationSeconds: Double? = nil,
    source: Source? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.MediaInfo.typename,
        "CurrentTimeSeconds": currentTimeSeconds,
        "DurationSeconds": durationSeconds,
        "Source": source._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(MediaInfoAttrs.self)
      ]
    ))
  }

  /// Source
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
          ObjectIdentifier(MediaInfoAttrs.Source.self),
          ObjectIdentifier(SourceAttrs.self)
        ]
      ))
    }
  }
}
