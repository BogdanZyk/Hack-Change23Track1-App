// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct PlaylistRowAttrs: SchemaAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment PlaylistRowAttrs on PlaylistRow { __typename Id Index Source { __typename ...SourceAttrs } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String?.self),
    .field("Index", Int?.self),
    .field("Source", Source?.self),
  ] }

  public var id: String? { __data["Id"] }
  public var index: Int? { __data["Index"] }
  public var source: Source? { __data["Source"] }

  public init(
    id: String? = nil,
    index: Int? = nil,
    source: Source? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.PlaylistRow.typename,
        "Id": id,
        "Index": index,
        "Source": source._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(PlaylistRowAttrs.self)
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
          ObjectIdentifier(PlaylistRowAttrs.Source.self),
          ObjectIdentifier(SourceAttrs.self)
        ]
      ))
    }
  }
}
