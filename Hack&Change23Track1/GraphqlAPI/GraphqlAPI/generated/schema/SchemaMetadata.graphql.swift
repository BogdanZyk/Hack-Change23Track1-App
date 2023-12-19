// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SchemaAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol SchemaAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public protocol SchemaAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SchemaAPI.SchemaMetadata {}

public protocol SchemaAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SchemaAPI.SchemaMetadata {}

public extension SchemaAPI {
  typealias ID = String

  typealias SelectionSet = SchemaAPI_SelectionSet

  typealias InlineFragment = SchemaAPI_InlineFragment

  typealias MutableSelectionSet = SchemaAPI_MutableSelectionSet

  typealias MutableInlineFragment = SchemaAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "RootMutationType": return SchemaAPI.Objects.RootMutationType
      case "Token": return SchemaAPI.Objects.Token
      case "RootQueryType": return SchemaAPI.Objects.RootQueryType
      case "User": return SchemaAPI.Objects.User
      case "PaginatedRooms": return SchemaAPI.Objects.PaginatedRooms
      case "Room": return SchemaAPI.Objects.Room
      case "MediaInfo": return SchemaAPI.Objects.MediaInfo
      case "Source": return SchemaAPI.Objects.Source
      case "PlaylistRow": return SchemaAPI.Objects.PlaylistRow
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}