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
      case "Audio": return SchemaAPI.Objects.Audio
      case "Room": return SchemaAPI.Objects.Room
      case "PlayFile": return SchemaAPI.Objects.PlayFile
      case "ClientSDP": return SchemaAPI.Objects.ClientSDP
      case "StickerPack": return SchemaAPI.Objects.StickerPack
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}